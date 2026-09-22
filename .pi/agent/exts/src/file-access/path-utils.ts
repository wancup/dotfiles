import { realpathSync } from "node:fs";
import { homedir } from "node:os";
import { basename, resolve } from "node:path";

const FORBIDDEN_BASENAME_PATTERNS = [
  /^\.env(\..*)?$/, // .env, .env.local, .env.production, etc.
  /^\.netrc$/,
  /^\.npmrc$/, // npm auth tokens
];

const FORBIDDEN_PATH_PATTERNS = [
  /\.ssh\//,
  /keys\//,
];

export function normalizePath(filePath: string): string {
  return filePath.startsWith("@") ? filePath.slice(1) : filePath;
}

export function expandPath(filePath: string): string {
  return filePath.replace(/^~(\/|$)/, homedir() + "$1");
}

export function isForbiddenFile(absolutePath: string): boolean {
  const name = basename(absolutePath);
  if (FORBIDDEN_BASENAME_PATTERNS.some((p) => p.test(name))) return true;
  return FORBIDDEN_PATH_PATTERNS.some((p) => p.test(absolutePath));
}

export function isOutsideDirectory(absolutePath: string, baseDirectory: string): boolean {
  const directoryPrefix = baseDirectory.endsWith("/") ? baseDirectory : baseDirectory + "/";
  return !absolutePath.startsWith(directoryPrefix) && absolutePath !== baseDirectory;
}

export function isGlobalSkillPath(absolutePath: string): boolean {
  const globalSkillsDir = resolve(homedir(), ".agents/skills");
  try {
    const resolvedSkillsDir = realpathSync(globalSkillsDir);
    return !isOutsideDirectory(absolutePath, globalSkillsDir) || !isOutsideDirectory(absolutePath, resolvedSkillsDir);
  } catch {
    return false;
  }
}

function looksLikePath(token: string): boolean {
  if (token.startsWith("/>")) return false;
  if (token.startsWith(".") || token.startsWith("~") || token.startsWith("/")) return true;
  if (token.startsWith("**")) return true;
  if (token.includes("..")) return true;
  return false;
}

export function extractPathsFromCommand(command: string): string[] {
  return command
    .split(/\s+/)
    .filter((token) => token.length > 0)
    .map((token) => normalizePath(token))
    .filter((token) => looksLikePath(token));
}
