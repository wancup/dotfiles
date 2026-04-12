import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { createPatterns, evaluateCommand } from "./permissions.ts";

describe("createPatterns", () => {
  it("単語境界でマッチする正規表現を生成する", () => {
    const patterns = createPatterns(["rm -rf"]);
    assert.equal(patterns.length, 1);
    assert.ok(patterns[0]!.test("rm -rf /tmp"));
  });

  it("空白の差異を吸収する（\\s+）", () => {
    const patterns = createPatterns(["rm -rf"]);
    assert.ok(patterns[0]!.test("rm  -rf /tmp"));
    assert.ok(patterns[0]!.test("rm\t-rf /tmp"));
  });

  it("大文字小文字を区別しない", () => {
    const patterns = createPatterns(["sudo"]);
    assert.ok(patterns[0]!.test("SUDO ls"));
    assert.ok(patterns[0]!.test("Sudo ls"));
  });

  it("部分文字列にはマッチしない（単語境界）", () => {
    const patterns = createPatterns(["rm -rf"]);
    assert.ok(!patterns[0]!.test("alarm -rf"));
  });

  it("空配列を渡すと空配列を返す", () => {
    const patterns = createPatterns([]);
    assert.equal(patterns.length, 0);
  });
});

describe("evaluateCommand – deny", () => {
  const denyCases = [
    ["npx some-package", "npx"],
    ["pnpx create-app", "pnpx"],
    ["pnpm dlx degit", "pnpm dlx"],
    ["npm i express", "npm i"],
    ["npm install express", "npm install"],
    ["yarn add react", "yarn add"],
    ["pnpm i lodash", "pnpm i"],
    ["pnpm install lodash", "pnpm install"],
    ["pnpm add lodash", "pnpm add"],
    ["sudo rm /etc/hosts", "sudo"],
    ["chmod 777 file.txt", "chmod"],
    ["chown root file.txt", "chown"],
  ] as const;

  for (const [command, keyword] of denyCases) {
    it(`"${keyword}" を含むコマンドは deny: ${command}`, () => {
      assert.equal(evaluateCommand(command), "deny");
    });
  }

  it("コマンド中間に deny キーワードがある場合も deny", () => {
    assert.equal(evaluateCommand("echo hello && sudo reboot"), "deny");
  });
});

describe("evaluateCommand – allow", () => {
  const allowCases = [
    ["ls", "ls"],
    ["ls -la", "ls"],
    ["ls /tmp", "ls"],
  ] as const;

  for (const [command, keyword] of allowCases) {
    it(`"${keyword}" を含むコマンドは allow: ${command}`, () => {
      assert.equal(evaluateCommand(command), "allow");
    });
  }
});

describe("evaluateCommand – ask (デフォルト)", () => {
  const askCases = [
    "echo hello",
    "cat file.txt",
    "grep -r pattern .",
    "node script.js",
    "git status",
    "rm file.txt",
    "rm -rf /tmp/test",
    "rm -f file.txt",
  ];

  for (const command of askCases) {
    it(`allowリストにないコマンドはデフォルトで ask: ${command}`, () => {
      assert.equal(evaluateCommand(command), "ask");
    });
  }

  it("余分な空白があっても ask と判定する", () => {
    assert.equal(evaluateCommand("rm  -rf /tmp"), "ask");
  });
});

describe("evaluateCommand – 優先順位", () => {
  it("deny と ask の両方にマッチする場合は deny が優先", () => {
    // "sudo rm -rf /" は deny(sudo) と ask(デフォルト) の両方にマッチ
    assert.equal(evaluateCommand("sudo rm -rf /"), "deny");
  });

  it("deny と allow の両方にマッチする場合は deny が優先", () => {
    assert.equal(evaluateCommand("sudo ls"), "deny");
  });
});
