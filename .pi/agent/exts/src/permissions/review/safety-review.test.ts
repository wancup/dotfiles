import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { fallbackReview, parseSafetyReview } from "./safety-review.ts";

describe("parseSafetyReview", () => {
  it("JSONのsafe判定と説明をパースする", () => {
    assert.deepEqual(
      parseSafetyReview('{"classification":"safe","description":"ファイル一覧を表示します。"}'),
      {
        classification: "safe",
        description: "ファイル一覧を表示します。",
      },
    );
  });

  it("コードフェンス内のJSONもパースする", () => {
    assert.deepEqual(
      parseSafetyReview('```json\n{"classification":"dangerous","description":"ファイルを削除します。"}\n```'),
      {
        classification: "dangerous",
        description: "ファイルを削除します。",
      },
    );
  });

  it("別名フィールドのclassificationと説明を受け付ける", () => {
    assert.deepEqual(
      parseSafetyReview('{"result":"不明","reason":"安全と言い切れません。"}'),
      {
        classification: "unknown",
        description: "安全と言い切れません。",
      },
    );
  });

  it("未知のclassificationはunknownに正規化する", () => {
    assert.deepEqual(
      parseSafetyReview('{"classification":"maybe","description":"判断できません。"}'),
      {
        classification: "unknown",
        description: "判断できません。",
      },
    );
  });

  it("不正なJSONはunknownを返す", () => {
    const result = parseSafetyReview("not json");
    assert.equal(result.classification, "unknown");
    assert.ok(result.description.length > 0);
  });
});

describe("fallbackReview", () => {
  it("指定した説明でunknown判定を作る", () => {
    assert.deepEqual(fallbackReview("失敗しました。"), {
      classification: "unknown",
      description: "失敗しました。",
    });
  });
});
