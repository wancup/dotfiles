import {
  type AssistantMessage,
  hasApi,
  type Model,
  normalizeContext,
  type OpenAICodexResponsesOptions,
  type Provider,
  type TranscriptContext,
} from "@earendil-works/pi-ai";
import type { ExtensionContext } from "@earendil-works/pi-coding-agent";
import { type CommandGateConfig, loadCommandGateConfig } from "./command-gate-config.ts";
import { fallbackReview, parseSafetyReview, type SafetyReview } from "./safety-review.ts";

export const SAFETY_MODEL_PROVIDER = "openai-codex";
export const SAFETY_MODEL_ID = "gpt-6-luna";
export const SAFETY_MODEL_API = "openai-codex-responses";

export type CompleteSafetyReview = (
  provider: Provider,
  model: Model<typeof SAFETY_MODEL_API>,
  context: TranscriptContext,
  options: OpenAICodexResponsesOptions,
) => Promise<AssistantMessage>;

const completeWithProvider: CompleteSafetyReview = (provider, model, context, options) =>
  provider.stream(model, context, options).result();

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
    "上記はプロジェクト開発者が意図的に許可したコマンドです。実行予定のbashコマンドの内容が一致する場合は書き込みを含む操作であっても原則としてsafeに分類してください。",
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
    "書き込みや削除の有無だけではなく、操作の対象・目的・範囲と、既存データやユーザー環境への影響を評価してください。",
    "",
    "判定ラベル:",
    "- safe: 読み取り専用の情報取得や状態確認、または対象と影響が限定され、有害な影響がないと判断できる安全な開発操作",
    "- dangerous: 通常のソースやユーザーデータの削除、意図しない破壊的な上書き、権限変更、所有者変更、インストール、外部コード実行、秘密情報の表示や外部送信など、ユーザー環境に有害な影響を与え得る操作",
    "- unknown: 対象、展開結果、処理内容など、安全性を判断するために必要な情報が不足している操作。内容不明のスクリプト実行などを含む",
    "",
    "プロジェクト内の安全な開発操作:",
    "- プロジェクト内とはCWD配下を指す。相対パスはCWDを基準に解釈し、`../`などで範囲外に出る対象は含めない",
    "- 対象と影響が限定されたファイル・ディレクトリの作成、編集、整形、ビルド成果物の生成・更新は、有害な影響がないと判断できる場合にsafeに分類する。既存ファイルへの書き込みや上書きという理由だけでdangerousにしない",
    "- CWD配下の一時ファイルや生成物の削除も、対象が限定され、安全な後片付けだと判断できる場合はsafeに分類する。通常のソースやユーザーデータの削除はこの例外に含めない",
    "- 対象が一時ファイルや生成物なのか、削除範囲が限定されているのか判断できない場合は、推測でsafeにせずunknownに分類する",
    "- CWD外への書き込みや削除は、この安全な開発操作の基準で自動許可しない。ただし、以下の一時書き込みや許可コマンドの基準は別途適用する",
    "",
    "変数展開・コマンド置換・複合コマンド:",
    "- 構文だけを理由にunknownにしない。各操作、対象、安全性に関わる展開結果を判断できる場合は、コマンド全体の影響を評価する",
    "- 全体が安全な操作のみならsafe、有害な操作を含むならdangerous、安全性に関わる重要な情報が不足する場合はunknownに分類する",
    "",
    "一時ディレクトリへの書き込み:",
    "- `/tmp/`またはCWD直下の`.__tmp/`における一時ファイルやディレクトリの作成、書き込み、上書きは、ほかに危険な操作を含まない限りsafeに分類する",
    "",
    "必ずJSONだけを返してください。Markdownやコードフェンスは不要です。",
    "commandDescriptionにはコマンド自体が何をするかだけを書き、分類理由は含めないでください。",
    "classificationReasonにはその分類にした判断根拠だけを書き、コマンド説明は繰り返さないでください。",
    "形式:",
    "{\"classification\":\"safe|dangerous|unknown\",\"commandDescription\":\"コマンド自体が何をするかを日本語で簡潔に説明\",\"classificationReason\":\"その分類にした判断根拠を日本語で簡潔に説明\"}",
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

    if (!hasApi(model, SAFETY_MODEL_API)) {
      return fallbackReview(
        `安全性判定モデル ${SAFETY_MODEL_PROVIDER}/${SAFETY_MODEL_ID} のAPIが${SAFETY_MODEL_API}ではありませんでした: ${model.api}`,
      );
    }

    const provider = ctx.modelRegistry.getProvider(model.provider);
    if (!provider) {
      return fallbackReview(`安全性判定プロバイダー ${model.provider} が見つかりませんでした。`);
    }

    const auth = await ctx.modelRegistry.getApiKeyAndHeaders(model);
    if (!auth.ok) {
      return fallbackReview(`安全性判定モデルの認証情報を取得できませんでした: ${auth.error}`);
    }

    if (!auth.apiKey) {
      return fallbackReview(`安全性判定モデル ${SAFETY_MODEL_PROVIDER}/${SAFETY_MODEL_ID} のAPIキーがありません。`);
    }

    try {
      const options: OpenAICodexResponsesOptions = {
        apiKey: auth.apiKey,
        maxTokens: 800,
        timeoutMs: 30_000,
        reasoningEffort: "low",
      };
      if (auth.headers) options.headers = auth.headers;
      if (auth.env) options.env = auth.env;
      if (ctx.signal) options.signal = ctx.signal;

      const commandGateConfig = await loadConfig(ctx);
      const response = await completeSafetyReview(
        provider,
        model,
        normalizeContext({
          messages: [
            {
              role: "user",
              content: [{ type: "text", text: buildPrompt(command, ctx.cwd, commandGateConfig.allow) }],
              timestamp: Date.now(),
            },
          ],
        }),
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

export const reviewCommandSafety = createCommandSafetyReviewer(completeWithProvider);
