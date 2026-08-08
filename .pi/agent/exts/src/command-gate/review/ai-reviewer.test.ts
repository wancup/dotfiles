import type {
  Api,
  AssistantMessage,
  Context,
  Model,
  OpenAICodexResponsesOptions,
  Provider,
} from "@earendil-works/pi-ai";
import type { ExtensionContext } from "@earendil-works/pi-coding-agent";
import assert from "node:assert/strict";
import { describe, it } from "node:test";
import {
  type BuildSafetyReviewPrompt,
  buildSafetyReviewPrompt,
  type CompleteSafetyReview,
  createCommandSafetyReviewer,
  SAFETY_MODEL_API,
  SAFETY_MODEL_ID,
  SAFETY_MODEL_PROVIDER,
} from "./ai-reviewer.ts";

const model: Model<typeof SAFETY_MODEL_API> = {
  id: SAFETY_MODEL_ID,
  name: SAFETY_MODEL_ID,
  api: "openai-codex-responses",
  provider: SAFETY_MODEL_PROVIDER,
  baseUrl: "https://example.com",
  reasoning: true,
  input: ["text"],
  cost: {
    input: 0,
    output: 0,
    cacheRead: 0,
    cacheWrite: 0,
  },
  contextWindow: 128000,
  maxTokens: 4096,
};

const safetyProvider = { id: SAFETY_MODEL_PROVIDER } as Provider;

function assistantMessage(text: string): AssistantMessage {
  return {
    role: "assistant",
    content: [{ type: "text", text }],
    api: model.api,
    provider: model.provider,
    model: model.id,
    usage: {
      input: 0,
      output: 0,
      cacheRead: 0,
      cacheWrite: 0,
      totalTokens: 0,
      cost: {
        input: 0,
        output: 0,
        cacheRead: 0,
        cacheWrite: 0,
        total: 0,
      },
    },
    stopReason: "stop",
    timestamp: Date.now(),
  };
}

function context(options?: {
  foundModel?: Model<Api>;
  provider?: Provider | null;
  auth?: Awaited<ReturnType<ExtensionContext["modelRegistry"]["getApiKeyAndHeaders"]>>;
  signal?: AbortSignal;
  trusted?: boolean;
}): ExtensionContext {
  return {
    cwd: "/repo",
    signal: options?.signal,
    isProjectTrusted: () => options?.trusted ?? false,
    modelRegistry: {
      find(provider: string, modelId: string) {
        if (provider === SAFETY_MODEL_PROVIDER && modelId === SAFETY_MODEL_ID) {
          return options?.foundModel;
        }
        return undefined;
      },
      getProvider(providerId: string) {
        if (providerId !== SAFETY_MODEL_PROVIDER || options?.provider === null) return undefined;
        return options?.provider ?? safetyProvider;
      },
      async getApiKeyAndHeaders() {
        return options?.auth ?? { ok: true, apiKey: "test-key" };
      },
    },
  } as unknown as ExtensionContext;
}

describe("buildSafetyReviewPrompt", () => {
  it("コマンドとCWDを含み、JSON形式を指示する", () => {
    const prompt = buildSafetyReviewPrompt("ls -la", "/repo");

    assert.match(prompt, /CWD: \/repo/);
    assert.match(prompt, /ls -la/);
    assert.match(prompt, /classification/);
    assert.match(prompt, /commandDescription/);
    assert.match(prompt, /classificationReason/);
    assert.match(prompt, /safe\|caution\|dangerous\|unknown/);
  });

  it("許可コマンドをプロンプトに含める", () => {
    const prompt = buildSafetyReviewPrompt("pnpm test", "/repo", ["pnpm test", "pnpm typecheck"]);

    assert.match(prompt, /pnpm test/);
    assert.match(prompt, /pnpm typecheck/);
  });
});

describe("createCommandSafetyReviewer", () => {
  it("モデル応答をSafetyReviewとして返す", async () => {
    let receivedProvider: Provider | undefined;
    let receivedContext: Context | undefined;
    let receivedOptions: OpenAICodexResponsesOptions | undefined;
    const complete: CompleteSafetyReview = async (provider, _model, requestContext, options) => {
      receivedProvider = provider;
      receivedContext = requestContext;
      receivedOptions = options;
      return assistantMessage(
        "{\"classification\":\"safe\",\"commandDescription\":\"一覧を表示します。\",\"classificationReason\":\"読み取り専用の操作です。\"}",
      );
    };

    const review = await createCommandSafetyReviewer(complete)(
      "ls -la",
      context({
        foundModel: model,
        auth: {
          ok: true,
          apiKey: "test-key",
          headers: { "x-test": "1" },
          env: { HTTPS_PROXY: "https://proxy.example.com" },
        },
      }),
    );

    assert.deepEqual(review, {
      classification: "safe",
      commandDescription: "一覧を表示します。",
      classificationReason: "読み取り専用の操作です。",
    });
    assert.equal(receivedProvider, safetyProvider);
    assert.equal(receivedOptions?.apiKey, "test-key");
    assert.deepEqual(receivedOptions?.headers, { "x-test": "1" });
    assert.deepEqual(receivedOptions?.env, { HTTPS_PROXY: "https://proxy.example.com" });
    assert.match(JSON.stringify(receivedContext), /ls -la/);
  });

  it("読み込んだ許可コマンドをプロンプトビルダーに渡す", async () => {
    let receivedContext: Context | undefined;
    let receivedPromptInput: Parameters<BuildSafetyReviewPrompt> | undefined;
    const complete: CompleteSafetyReview = async (_provider, _model, requestContext) => {
      receivedContext = requestContext;
      return assistantMessage(
        "{\"classification\":\"safe\",\"commandDescription\":\"テストを実行します。\",\"classificationReason\":\"プロンプトビルダーに渡された情報で判定します。\"}",
      );
    };
    const buildPrompt: BuildSafetyReviewPrompt = (...args) => {
      receivedPromptInput = args;
      return "安全性判定プロンプト";
    };

    await createCommandSafetyReviewer(
      complete,
      async (ctx) => {
        assert.equal(ctx.cwd, "/repo");
        return { allow: ["pnpm test"] };
      },
      buildPrompt,
    )("pnpm test", context({ foundModel: model }));

    assert.deepEqual(receivedPromptInput, ["pnpm test", "/repo", ["pnpm test"]]);
    assert.deepEqual(receivedContext?.messages[0]?.content, [{ type: "text", text: "安全性判定プロンプト" }]);
  });

  it("モデルが見つからない場合はunknownにする", async () => {
    const review = await createCommandSafetyReviewer(async () => assistantMessage("{}"))(
      "ls",
      context(),
    );

    assert.equal(review.classification, "unknown");
    assert.match(review.classificationReason, /モデル.*見つかりません/);
  });

  it("モデルのAPIが想定と異なる場合はunknownにする", async () => {
    const mismatchedModel: Model<Api> = { ...model, api: "openai-responses" };
    const review = await createCommandSafetyReviewer(async () => assistantMessage("{}"))(
      "ls",
      context({ foundModel: mismatchedModel }),
    );

    assert.equal(review.classification, "unknown");
    assert.match(review.classificationReason, /API.*openai-codex-responses/);
  });

  it("プロバイダーが見つからない場合はunknownにする", async () => {
    const review = await createCommandSafetyReviewer(async () => assistantMessage("{}"))(
      "ls",
      context({ foundModel: model, provider: null }),
    );

    assert.equal(review.classification, "unknown");
    assert.match(review.classificationReason, /プロバイダー.*見つかりません/);
  });

  it("APIキーがない場合はunknownにする", async () => {
    const review = await createCommandSafetyReviewer(async () => assistantMessage("{}"))(
      "ls",
      context({ foundModel: model, auth: { ok: true } }),
    );

    assert.equal(review.classification, "unknown");
    assert.match(review.classificationReason, /APIキー/);
  });

  it("モデル呼び出しが失敗した場合はunknownにする", async () => {
    const review = await createCommandSafetyReviewer(async () => {
      throw new Error("network error");
    })("ls", context({ foundModel: model }));

    assert.equal(review.classification, "unknown");
    assert.match(review.classificationReason, /network error/);
  });

  it("モデル応答が空の場合はunknownにする", async () => {
    const review = await createCommandSafetyReviewer(async () => assistantMessage(""))(
      "ls",
      context({ foundModel: model }),
    );

    assert.equal(review.classification, "unknown");
    assert.match(review.classificationReason, /空の応答/);
  });
});
