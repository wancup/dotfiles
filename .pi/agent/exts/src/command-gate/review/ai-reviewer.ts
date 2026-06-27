import {
  type Api,
  type AssistantMessage,
  complete,
  type Context,
  type Model,
  type ProviderStreamOptions,
} from "@earendil-works/pi-ai";
import type { ExtensionContext } from "@earendil-works/pi-coding-agent";
import { type CommandGateConfig, loadCommandGateConfig } from "./command-gate-config.ts";
import { fallbackReview, parseSafetyReview, type SafetyReview } from "./safety-review.ts";

export const SAFETY_MODEL_PROVIDER = "openai-codex";
export const SAFETY_MODEL_ID = "gpt-5.4-mini";

export type CompleteSafetyReview = (
  model: Model<Api>,
  context: Context,
  options: ProviderStreamOptions,
) => Promise<AssistantMessage>;

export type LoadCommandGateConfigForReview = (ctx: ExtensionContext) => Promise<CommandGateConfig>;

export type BuildSafetyReviewPrompt = (command: string, cwd: string, allowedCommands: string[]) => string;

async function loadProjectCommandGateConfig(ctx: ExtensionContext): Promise<CommandGateConfig> {
  return loadCommandGateConfig(ctx.cwd, {
    isProjectTrusted: () => ctx.isProjectTrusted(),
  });
}

function formatAllowedCommands(allowedCommands: string[]): string[] {
  if (allowedCommands.length === 0) return [];

  return [
    "",
    "プロジェクト開発者が許可したコマンド:",
    ...allowedCommands.map((allowedCommand) => `- ${allowedCommand}`),
    "",
    "上記はプロジェクト開発者が意図的に許可したコマンドです。実行予定のbashコマンドの内容が一致する場合は原則としてsafeに分類してください。",
    "ただし、実行予定のbashコマンドに許可コマンド以外の操作が含まれる場合は、その追加操作の安全性も含めてコマンド全体を判定してください。",
  ];
}

export function buildSafetyReviewPrompt(
  command: string,
  cwd: string,
  allowedCommands: string[] = [],
): string {
  return [
    "あなたはローカル開発環境で実行されるbashコマンドの安全性を判定するセキュリティレビュアーです。",
    "ユーザー環境への影響を保守的に評価してください。",
    "",
    "判定ラベル:",
    "- safe: 読み取り専用の情報取得や状態確認で、ファイル、設定、依存関係、権限、ネットワーク状態を変更しないと判断できる",
    "- caution: ファイルや環境への変更は起こり得るが、削除、権限変更、インストール、外部コード実行などの明確な危険操作ではない",
    "- dangerous: 削除、上書き、権限変更、所有者変更、インストール、外部コード実行、秘密情報の表示など、ユーザー環境に有害な影響を与え得る",
    "- unknown: 変数展開、コマンド置換、複合コマンド、内容不明のスクリプト実行など、安全と言い切れない",
    "",
    "必ずJSONだけを返してください。Markdownやコードフェンスは不要です。",
    "commandDescriptionにはコマンド自体が何をするかだけを書き、分類理由は含めないでください。",
    "classificationReasonにはその分類にした判断根拠だけを書き、コマンド説明は繰り返さないでください。",
    "形式:",
    "{\"classification\":\"safe|caution|dangerous|unknown\",\"commandDescription\":\"コマンド自体が何をするかを日本語で簡潔に説明\",\"classificationReason\":\"その分類にした判断根拠を日本語で簡潔に説明\"}",
    "",
    `CWD: ${cwd}`,
    "実行予定のbashコマンド:",
    command,
    ...formatAllowedCommands(allowedCommands),
  ].join("\n");
}

function extractTextContent(message: AssistantMessage): string {
  return message.content
    .filter((content): content is { type: "text"; text: string } => content.type === "text")
    .map((content) => content.text)
    .join("\n")
    .trim();
}

export function createCommandSafetyReviewer(
  completeSafetyReview: CompleteSafetyReview,
  loadConfig: LoadCommandGateConfigForReview = loadProjectCommandGateConfig,
  buildPrompt: BuildSafetyReviewPrompt = buildSafetyReviewPrompt,
) {
  return async function reviewCommandSafety(
    command: string,
    ctx: ExtensionContext,
  ): Promise<SafetyReview> {
    const model = ctx.modelRegistry.find(SAFETY_MODEL_PROVIDER, SAFETY_MODEL_ID);
    if (!model) {
      return fallbackReview(`安全性判定モデル ${SAFETY_MODEL_PROVIDER}/${SAFETY_MODEL_ID} が見つかりませんでした。`);
    }

    const auth = await ctx.modelRegistry.getApiKeyAndHeaders(model);
    if (!auth.ok) {
      return fallbackReview(`安全性判定モデルの認証情報を取得できませんでした: ${auth.error}`);
    }

    if (!auth.apiKey) {
      return fallbackReview(`安全性判定モデル ${SAFETY_MODEL_PROVIDER}/${SAFETY_MODEL_ID} のAPIキーがありません。`);
    }

    try {
      const options: ProviderStreamOptions = {
        apiKey: auth.apiKey,
        maxTokens: 800,
        timeoutMs: 30_000,
        reasoningEffort: "low",
      };
      if (auth.headers) options.headers = auth.headers;
      if (ctx.signal) options.signal = ctx.signal;

      const commandGateConfig = await loadConfig(ctx);
      const response = await completeSafetyReview(
        model,
        {
          messages: [
            {
              role: "user",
              content: [{ type: "text", text: buildPrompt(command, ctx.cwd, commandGateConfig.allow) }],
              timestamp: Date.now(),
            },
          ],
        },
        options,
      );

      const text = extractTextContent(response);
      if (!text) {
        return fallbackReview("安全性判定モデルから空の応答が返されました。");
      }

      return parseSafetyReview(text);
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      return fallbackReview(`安全性判定モデルの呼び出しに失敗しました: ${message}`);
    }
  };
}

export const reviewCommandSafety = createCommandSafetyReviewer(complete);
