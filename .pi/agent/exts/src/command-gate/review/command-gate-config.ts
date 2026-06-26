import { readFile } from "node:fs/promises";
import { resolve } from "node:path";

export type CommandGateConfig = {
  allow: string[];
};

export type ReadCommandGateConfigFile = (path: string) => Promise<string>;

export type LoadCommandGateConfigOptions = {
  isProjectTrusted: () => boolean;
  readTextFile?: ReadCommandGateConfigFile;
};

const defaultReadTextFile: ReadCommandGateConfigFile = (path) => readFile(path, "utf8");

function parseCommandGateConfig(text: string): CommandGateConfig {
  const parsed = JSON.parse(text) as { allow?: unknown };
  const allow = Array.isArray(parsed.allow)
    ? parsed.allow.filter((value): value is string => typeof value === "string" && value.trim().length > 0)
    : [];

  return { allow };
}

export async function loadCommandGateConfig(
  cwd: string,
  options: LoadCommandGateConfigOptions,
): Promise<CommandGateConfig> {
  if (!options.isProjectTrusted()) {
    return { allow: [] };
  }

  const readTextFile = options.readTextFile ?? defaultReadTextFile;
  const configPath = resolve(cwd, ".pi", "command-gate.json");

  try {
    return parseCommandGateConfig(await readTextFile(configPath));
  } catch {
    return { allow: [] };
  }
}
