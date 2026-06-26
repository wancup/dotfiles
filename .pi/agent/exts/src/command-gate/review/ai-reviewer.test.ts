import type { Api, AssistantMessage, Context, Model, ProviderStreamOptions } from "@earendil-works/pi-ai";
import type { ExtensionContext } from "@earendil-works/pi-coding-agent";
import assert from "node:assert/strict";
import { describe, it } from "node:test";
import {
  buildSafetyReviewPrompt,
  type CompleteSafetyReview,
  createCommandSafetyReviewer,
  SAFETY_MODEL_ID,
  SAFETY_MODEL_PROVIDER,
} from "./ai-reviewer.ts";

const model: Model<Api> = {
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
  auth?: Awaited<ReturnType<ExtensionContext["modelRegistry"]["getApiKeyAndHeaders"]>>;
  signal?: AbortSignal;
}): ExtensionContext {
  return {
    cwd: "/repo",
    signal: options?.signal,
    modelRegistry: {
      find(provider: string, modelId: string) {
        if (provider === SAFETY_MODEL_PROVIDER && modelId === SAFETY_MODEL_ID) {
          return options?.foundModel;
        }
        return undefined;
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
});

describe("createCommandSafetyReviewer", () => {
  it("モデル応答をSafetyReviewとして返す", async () => {
    let receivedContext: Context | undefined;
    let receivedOptions: ProviderStreamOptions | undefined;
    const complete: CompleteSafetyReview = async (_model, requestContext, options) => {
      receivedContext = requestContext;
      receivedOptions = options;
      return assistantMessage(
        "{\"classification\":\"safe\",\"commandDescription\":\"一覧を表示します。\",\"classificationReason\":\"読み取り専用の操作です。\"}",
      );
    };

    const review = await createCommandSafetyReviewer(complete)(
      "ls -la",
      context({ foundModel: model, auth: { ok: true, apiKey: "test-key", headers: { "x-test": "1" } } }),
    );

    assert.deepEqual(review, {
      classification: "safe",
      commandDescription: "一覧を表示します。",
      classificationReason: "読み取り専用の操作です。",
    });
    assert.equal(receivedOptions?.apiKey, "test-key");
    assert.deepEqual(receivedOptions?.headers, { "x-test": "1" });
    assert.match(JSON.stringify(receivedContext), /ls -la/);
  });

  it("モデルが見つからない場合はunknownにする", async () => {
    const review = await createCommandSafetyReviewer(async () => assistantMessage("{}"))(
      "ls",
      context(),
    );

    assert.equal(review.classification, "unknown");
    assert.match(review.classificationReason, /モデル.*見つかりません/);
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
