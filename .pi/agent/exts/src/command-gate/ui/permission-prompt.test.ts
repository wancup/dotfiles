import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { buildPermissionPrompt, classificationLabel } from "./permission-prompt.ts";

describe("classificationLabel", () => {
  it("classificationを日本語ラベルに変換する", () => {
    assert.equal(classificationLabel("safe"), "安全");
    assert.equal(classificationLabel("caution"), "注意");
    assert.equal(classificationLabel("dangerous"), "危険");
    assert.equal(classificationLabel("unknown"), "不明");
  });
});

describe("buildPermissionPrompt", () => {
  it("コマンド、判定、コマンド説明、分類根拠を含む確認文を作る", () => {
    const prompt = buildPermissionPrompt("rm -rf tmp", {
      classification: "dangerous",
      commandDescription: "tmpを再帰的に削除します。",
      classificationReason: "削除操作を含むため危険です。",
    });

    assert.match(prompt, /```bash\nrm -rf tmp\n```/);
    assert.match(prompt, /AI判定: 危険/);
    assert.match(prompt, /コマンドの説明:\ntmpを再帰的に削除します。/);
    assert.match(prompt, /分類の根拠:\n削除操作を含むため危険です。/);
    assert.match(prompt, /実行を許可しますか？/);
  });
});
