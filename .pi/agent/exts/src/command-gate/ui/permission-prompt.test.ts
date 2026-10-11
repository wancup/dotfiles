import { Text } from "@earendil-works/pi-tui";
import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { buildPermissionPrompt, classificationLabel, resolveTerminalSize } from "./permission-prompt.ts";

const terminalSize = { columns: 80, rows: 48 };
const review = {
  classification: "dangerous",
  commandDescription: "tmpを再帰的に削除します。",
  classificationReason: "削除操作を含むため危険です。",
} as const;

describe("resolveTerminalSize", () => {
  it("TUIでは取得した端末サイズを使う", () => {
    assert.deepEqual(resolveTerminalSize("tui", 120, 60), { columns: 120, rows: 60 });
  });

  it("RPCや端末サイズが取得できない場合は80桁×48行を使う", () => {
    assert.deepEqual(resolveTerminalSize("rpc", 120, 60), terminalSize);
    assert.deepEqual(resolveTerminalSize("tui"), terminalSize);
  });
});

describe("classificationLabel", () => {
  it("classificationを日本語ラベルに変換する", () => {
    assert.equal(classificationLabel("safe"), "安全");
    assert.equal(classificationLabel("caution"), "注意");
    assert.equal(classificationLabel("dangerous"), "危険");
    assert.equal(classificationLabel("unknown"), "不明");
  });
});

describe("buildPermissionPrompt", () => {
  it("短いコマンドは省略せず、判定、コマンド説明、分類根拠を含む確認文を作る", () => {
    const [prompt, error] = buildPermissionPrompt("rm -rf tmp", review, terminalSize);

    assert.equal(error, null);
    assert.ok(prompt);
    assert.match(prompt, /```bash\nrm -rf tmp\n```/);
    assert.match(prompt, /AI判定: 危険/);
    assert.match(prompt, /コマンドの説明: tmpを再帰的に削除します。/);
    assert.match(prompt, /分類の根拠: 削除操作を含むため危険です。/);
    assert.match(prompt, /実行を許可しますか？/);
    assert.ok(!prompt.includes("-- (省略) --"));
  });

  it("長いコマンドは先頭と独立した省略行を表示する", () => {
    const [prompt, error] = buildPermissionPrompt(`echo ${"x".repeat(5000)}`, review, terminalSize);

    assert.equal(error, null);
    assert.ok(prompt);
    assert.match(prompt, /```bash\necho\b/);
    assert.ok(prompt.includes("\n-- (省略) --\n```"));
    assert.ok(new Text(prompt, 1, 0).render(terminalSize.columns).length <= terminalSize.rows - 16);
  });

  it("表示領域が不足する場合は文面をnullにしてエラー内容を返す", () => {
    assert.deepEqual(buildPermissionPrompt("echo hello", review, { ...terminalSize, rows: 16 }), [
      null,
      "確認画面の表示領域が不足しているため、コマンドの実行を拒否しました。",
    ]);
  });
});
