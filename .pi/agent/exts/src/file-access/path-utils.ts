import { homedir } from "node:os";
import { basename } from "node:path";

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

export function isOutsideCwd(absolutePath: string, cwd: string): boolean {
  const normalizedCwd = cwd.endsWith("/") ? cwd : cwd + "/";
  return !absolutePath.startsWith(normalizedCwd) && absolutePath !== cwd;
}

function looksLikePath(token: string): boolean {
  if (token.startsWith(".") || token.startsWith("~") || token.startsWith("/")) return true;
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
