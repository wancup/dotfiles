import { readFile } from "node:fs/promises";
import { resolve } from "node:path";

export type CommandReviewContext = {
  kind: "package.json";
  path: string;
  content: string;
  truncated: boolean;
};

export type ReadTextFile = (path: string) => Promise<string>;

export type CollectCommandReviewContextOptions = {
  readTextFile?: ReadTextFile;
};

export const MAX_PACKAGE_JSON_CONTEXT_BYTES = 64 * 1024;

const PACKAGE_MANAGER_KEYWORDS = ["npm", "pnpm", "yarn", "bun"] as const;

export function containsPackageManagerCommand(command: string): boolean {
  const lowerCommand = command.toLowerCase();
  return PACKAGE_MANAGER_KEYWORDS.some((keyword) => lowerCommand.includes(keyword));
}

function truncatePackageJsonContent(content: string): { content: string; truncated: boolean } {
  if (Buffer.byteLength(content, "utf8") <= MAX_PACKAGE_JSON_CONTEXT_BYTES) {
    return { content, truncated: false };
  }

  return {
    content: Buffer.from(content, "utf8").subarray(0, MAX_PACKAGE_JSON_CONTEXT_BYTES).toString("utf8"),
    truncated: true,
  };
}

const defaultReadTextFile: ReadTextFile = (path) => readFile(path, "utf8");

export async function collectCommandReviewContext(
  command: string,
  cwd: string,
  options: CollectCommandReviewContextOptions = {},
): Promise<CommandReviewContext[]> {
  if (!containsPackageManagerCommand(command)) {
    return [];
  }

  const packageJsonPath = resolve(cwd, "package.json");
  const readTextFile = options.readTextFile ?? defaultReadTextFile;
  try {
    const packageJson = truncatePackageJsonContent(await readTextFile(packageJsonPath));
    return [{ kind: "package.json", path: packageJsonPath, ...packageJson }];
  } catch {
    return [];
  }
}
