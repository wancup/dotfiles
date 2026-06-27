import { readFile } from "node:fs/promises";
import { resolve } from "node:path";

export const DEFAULT_ALLOWED_COMMANDS = [
  "gh issue list",
  "gh issue view",
  "gh pr checks",
  "gh pr list",
  "gh pr status",
  "gh pr view",
  "gh pr diff",
  "gh run list",
  "gh run view",
  "gh workflow list",
  "gh workflow view",
  "git diff",
  "git log",
  "git ls-files",
  "git rev-parse",
  "git show",
  "git status",
];

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

function mergeWithDefaultAllowedCommands(allowedCommands: string[] = []): CommandGateConfig {
  return { allow: [...new Set([...DEFAULT_ALLOWED_COMMANDS, ...allowedCommands])] };
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
    const projectConfig = parseCommandGateConfig(await readTextFile(configPath));
    return mergeWithDefaultAllowedCommands(projectConfig.allow);
  } catch {
    return mergeWithDefaultAllowedCommands();
  }
}
