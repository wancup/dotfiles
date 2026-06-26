import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { buildPermissionPrompt, classificationLabel } from "./permission-prompt.ts";

describe("classificationLabel", () => {
  it("classificationを日本語ラベルに変換する", () => {
    assert.equal(classificationLabel("safe"), "安全");
    assert.equal(classificationLabel("dangerous"), "危険");
    assert.equal(classificationLabel("unknown"), "不明");
  });
});

describe("buildPermissionPrompt", () => {
  it("コマンド、判定、説明を含む確認文を作る", () => {
    const prompt = buildPermissionPrompt("rm -rf tmp", {
      classification: "dangerous",
      description: "tmpを削除します。",
    });

    assert.match(prompt, /```bash\nrm -rf tmp\n```/);
    assert.match(prompt, /AI判定: 危険/);
    assert.match(prompt, /tmpを削除します。/);
    assert.match(prompt, /実行を許可しますか？/);
  });
});
