import { Text } from "@earendil-works/pi-tui";
import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { buildPermissionPrompt, classificationLabel, resolveTerminalColumns } from "./permission-prompt.ts";

const terminalColumns = 80;
const review = {
  classification: "dangerous",
  commandDescription: "tmpを再帰的に削除します。",
  classificationReason: "削除操作を含むため危険です。",
} as const;

describe("resolveTerminalColumns", () => {
  it("TUIでは取得した端末幅を使う", () => {
    assert.equal(resolveTerminalColumns("tui", 120), 120);
  });

  it("RPCや有効な端末幅が取得できない場合は80桁を使う", () => {
    assert.equal(resolveTerminalColumns("rpc", 120), terminalColumns);
    for (const columns of [undefined, 0, -1, 1.5, NaN, Infinity]) {
      assert.equal(resolveTerminalColumns("tui", columns), terminalColumns);
    }
  });
});

describe("classificationLabel", () => {
  it("classificationを日本語ラベルに変換する", () => {
    assert.equal(classificationLabel("safe"), "安全");
    assert.equal(classificationLabel("dangerous"), "危険");
    assert.equal(classificationLabel("unknown"), "不明");
  });
});

describe("buildPermissionPrompt", () => {
  it("短いコマンドは省略せず、判定、コマンド説明、分類根拠を含む確認文を作る", () => {
    const prompt = buildPermissionPrompt("rm -rf tmp", review, terminalColumns);
    assert.match(prompt, /```bash\nrm -rf tmp\n```/);
    assert.match(prompt, /AI判定: 危険/);
    assert.match(prompt, /コマンドの説明: tmpを再帰的に削除します。/);
    assert.match(prompt, /分類の根拠: 削除操作を含むため危険です。/);
    assert.match(prompt, /実行を許可しますか？/);
    assert.ok(!prompt.includes("-- (省略) --"));
  });

  it("折り返し後24行までは省略せず、25行以上は先頭24行と独立した省略行を表示する", () => {
    for (const columns of [40, terminalColumns, 120]) {
      for (
        const { line, separator } of [
          { line: "x".repeat(columns - 2), separator: "" },
          { line: "あ".repeat((columns - 2) / 2), separator: "" },
          { line: "echo hello", separator: "\n" },
        ]
      ) {
        for (const rows of [24, 25, 64]) {
          const command = Array(rows).fill(line).join(separator);
          assert.equal(new Text(command, 0, 0).render(columns - 2).length, rows);

          const prompt = buildPermissionPrompt(command, review, columns);
          const expectedCommand = rows <= 24
            ? command
            : `${Array(24).fill(line).join("\n")}\n-- (省略) --`;

          assert.ok(prompt.includes(`\`\`\`bash\n${expectedCommand}\n\`\`\``));
          assert.equal(prompt.includes("-- (省略) --"), rows > 24);
        }
      }
    }
  });
});
