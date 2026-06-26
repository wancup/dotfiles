import assert from "node:assert/strict";
import { resolve } from "node:path";
import { describe, it } from "node:test";
import { collectCommandReviewContext, MAX_PACKAGE_JSON_CONTEXT_BYTES, type ReadTextFile } from "./command-context.ts";

describe("collectCommandReviewContext", () => {
  it("パッケージマネージャ名を含むコマンドではpackage.jsonのパスと本文を収集する", async () => {
    const cwd = "/repo";
    const packageJsonPath = resolve(cwd, "package.json");
    const packageJson = "{\n  \"scripts\": {\n    \"test\": \"node --test\"\n  }\n}";
    const readTextFile: ReadTextFile = async (path) => {
      assert.equal(path, packageJsonPath);
      return packageJson;
    };

    const contexts = await collectCommandReviewContext("pnpm test", cwd, { readTextFile });

    assert.deepEqual(contexts, [
      {
        kind: "package.json",
        path: packageJsonPath,
        content: packageJson,
        truncated: false,
      },
    ]);
  });

  it("対象外コマンドやpackage.json読み込み失敗時は空配列を返す", async () => {
    const readTextFile: ReadTextFile = async () => {
      throw new Error("not found");
    };

    assert.deepEqual(await collectCommandReviewContext("git status", "/repo", { readTextFile }), []);
    assert.deepEqual(await collectCommandReviewContext("npm test", "/repo", { readTextFile }), []);
  });

  it("大きなpackage.jsonは一定サイズで切り詰める", async () => {
    const packageJson = `{"scripts":{"test":"${"x".repeat(MAX_PACKAGE_JSON_CONTEXT_BYTES)}"}}`;
    const readTextFile: ReadTextFile = async () => packageJson;

    const contexts = await collectCommandReviewContext("npm test", "/repo", { readTextFile });

    assert.equal(contexts.length, 1);
    assert.equal(contexts[0]!.truncated, true);
    assert.equal(Buffer.byteLength(contexts[0]!.content, "utf8"), MAX_PACKAGE_JSON_CONTEXT_BYTES);
    assert.equal(contexts[0]!.content, packageJson.slice(0, MAX_PACKAGE_JSON_CONTEXT_BYTES));
  });
});
