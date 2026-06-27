import assert from "node:assert/strict";
import { resolve } from "node:path";
import { describe, it } from "node:test";
import {
  DEFAULT_ALLOWED_COMMANDS,
  loadCommandGateConfig,
  type ReadCommandGateConfigFile,
} from "./command-gate-config.ts";

describe("loadCommandGateConfig", () => {
  it("信頼済みプロジェクトでは.pi/command-gate.jsonのallowを読み込み、デフォルト許可リストとマージする", async () => {
    const cwd = "/repo";
    const configPath = resolve(cwd, ".pi", "command-gate.json");
    const readTextFile: ReadCommandGateConfigFile = async (path) => {
      assert.equal(path, configPath);
      return JSON.stringify({ allow: ["pnpm test", "pnpm typecheck"] });
    };

    const config = await loadCommandGateConfig(cwd, {
      isProjectTrusted: () => true,
      readTextFile,
    });

    assert.deepEqual(config, { allow: [...DEFAULT_ALLOWED_COMMANDS, "pnpm test", "pnpm typecheck"] });
  });

  it("未信頼プロジェクトでは設定ファイルを読まずに空設定を返す", async () => {
    const readTextFile: ReadCommandGateConfigFile = async () => {
      throw new Error("未信頼プロジェクトでは読まれない想定");
    };

    const config = await loadCommandGateConfig("/repo", {
      isProjectTrusted: () => false,
      readTextFile,
    });

    assert.deepEqual(config, { allow: [] });
  });

  it("不正なJSONや不正なallowでもデフォルト許可リストを返す", async () => {
    const invalidJsonConfig = await loadCommandGateConfig("/repo", {
      isProjectTrusted: () => true,
      readTextFile: async () => "not json",
    });
    const invalidAllowConfig = await loadCommandGateConfig("/repo", {
      isProjectTrusted: () => true,
      readTextFile: async () => JSON.stringify({ allow: ["", 42, null] }),
    });

    assert.deepEqual(invalidJsonConfig, { allow: DEFAULT_ALLOWED_COMMANDS });
    assert.deepEqual(invalidAllowConfig, { allow: DEFAULT_ALLOWED_COMMANDS });
  });
});
