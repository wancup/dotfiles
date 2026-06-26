import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { containsDeniedCommand, createPatterns, evaluateCommand } from "./deny.ts";

describe("createPatterns", () => {
  it("単語境界でマッチする正規表現を生成する", () => {
    const patterns = createPatterns(["rm -rf"]);
    assert.equal(patterns.length, 1);
    assert.ok(patterns[0]!.test("rm -rf /tmp"));
  });

  it("空白の差異を吸収する", () => {
    const patterns = createPatterns(["rm -rf"]);
    assert.ok(patterns[0]!.test("rm  -rf /tmp"));
    assert.ok(patterns[0]!.test("rm\t-rf /tmp"));
  });

  it("大文字小文字を区別しない", () => {
    const patterns = createPatterns(["sudo"]);
    assert.ok(patterns[0]!.test("SUDO ls"));
    assert.ok(patterns[0]!.test("Sudo ls"));
  });

  it("部分文字列にはマッチしない", () => {
    const patterns = createPatterns(["rm -rf"]);
    assert.ok(!patterns[0]!.test("alarm -rf"));
  });
});

describe("containsDeniedCommand", () => {
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
    ["echo hello && sudo reboot", "sudo"],
  ] as const;

  for (const [command, keyword] of denyCases) {
    it(`"${keyword}"を含むコマンドを検出する: ${command}`, () => {
      assert.equal(containsDeniedCommand(command), true);
    });
  }

  it("denyコマンドを含まない場合はfalseを返す", () => {
    assert.equal(containsDeniedCommand("ls && git status"), false);
  });
});

describe("evaluateCommand", () => {
  it("denyキーワードがどこかに含まれていたらdeny", () => {
    assert.equal(evaluateCommand("echo hello && sudo reboot"), "deny");
  });

  it("denyキーワードが含まれていなければAI判定に回すためask", () => {
    assert.equal(evaluateCommand("ls -la"), "ask");
    assert.equal(evaluateCommand("git status"), "ask");
    assert.equal(evaluateCommand("rm -rf /tmp/test"), "ask");
  });
});
