import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { fallbackReview, parseSafetyReview } from "./safety-review.ts";

describe("parseSafetyReview", () => {
  it("JSONのsafe判定、コマンド説明、分類根拠をパースする", () => {
    assert.deepEqual(
      parseSafetyReview(
        "{\"classification\":\"safe\",\"commandDescription\":\"ファイル一覧を表示します。\",\"classificationReason\":\"読み取り専用の操作です。\"}",
      ),
      {
        classification: "safe",
        commandDescription: "ファイル一覧を表示します。",
        classificationReason: "読み取り専用の操作です。",
      },
    );
  });

  it("コードフェンス内のJSONもパースする", () => {
    assert.deepEqual(
      parseSafetyReview(
        "```json\n{\"classification\":\"dangerous\",\"commandDescription\":\"ファイルを削除します。\",\"classificationReason\":\"削除操作を含むため危険です。\"}\n```",
      ),
      {
        classification: "dangerous",
        commandDescription: "ファイルを削除します。",
        classificationReason: "削除操作を含むため危険です。",
      },
    );
  });

  it("旧形式のdescriptionだけではunknownを返す", () => {
    const result = parseSafetyReview("{\"classification\":\"safe\",\"description\":\"ファイル一覧を表示します。\"}");

    assert.equal(result.classification, "unknown");
    assert.ok(result.commandDescription.length > 0);
    assert.ok(result.classificationReason.length > 0);
  });

  it("未知または廃止したclassificationはunknownに正規化する", () => {
    for (const classification of ["maybe", "caution", "warning", "warn", "注意"]) {
      assert.deepEqual(
        parseSafetyReview(
          JSON.stringify({
            classification,
            commandDescription: "内容を確認します。",
            classificationReason: "判断できません。",
          }),
        ),
        {
          classification: "unknown",
          commandDescription: "内容を確認します。",
          classificationReason: "判断できません。",
        },
        classification,
      );
    }
  });

  it("不正なJSONはunknownを返す", () => {
    const result = parseSafetyReview("not json");
    assert.equal(result.classification, "unknown");
    assert.ok(result.commandDescription.length > 0);
    assert.ok(result.classificationReason.length > 0);
  });
});

describe("fallbackReview", () => {
  it("指定した説明を分類根拠にしたunknown判定を作る", () => {
    assert.deepEqual(fallbackReview("失敗しました。"), {
      classification: "unknown",
      commandDescription: "コマンドの動作内容を確認できませんでした。",
      classificationReason: "失敗しました。",
    });
  });
});
