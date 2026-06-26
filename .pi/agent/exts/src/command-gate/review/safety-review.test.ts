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

  it("caution判定と日本語の注意をパースする", () => {
    assert.deepEqual(
      parseSafetyReview(
        "{\"classification\":\"caution\",\"commandDescription\":\"ディレクトリを作成します。\",\"classificationReason\":\"ファイルシステムを変更する可能性があります。\"}",
      ),
      {
        classification: "caution",
        commandDescription: "ディレクトリを作成します。",
        classificationReason: "ファイルシステムを変更する可能性があります。",
      },
    );

    assert.deepEqual(
      parseSafetyReview(
        "{\"classification\":\"注意\",\"commandDescription\":\"ディレクトリを作成します。\",\"classificationReason\":\"新しいパスが作られます。\"}",
      ),
      {
        classification: "caution",
        commandDescription: "ディレクトリを作成します。",
        classificationReason: "新しいパスが作られます。",
      },
    );
  });

  it("旧形式のdescriptionだけではunknownを返す", () => {
    const result = parseSafetyReview("{\"classification\":\"safe\",\"description\":\"ファイル一覧を表示します。\"}");

    assert.equal(result.classification, "unknown");
    assert.ok(result.commandDescription.length > 0);
    assert.ok(result.classificationReason.length > 0);
  });

  it("未知のclassificationはunknownに正規化する", () => {
    assert.deepEqual(
      parseSafetyReview(
        "{\"classification\":\"maybe\",\"commandDescription\":\"内容を確認します。\",\"classificationReason\":\"判断できません。\"}",
      ),
      {
        classification: "unknown",
        commandDescription: "内容を確認します。",
        classificationReason: "判断できません。",
      },
    );
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
