export const ALLOW_COMMANDS = [
  "ls",
  "find",
  "head",
  "tail",
  "mkdir",
  "grep",
  "rg",
  "git diff",
  "git log",
  "git show",
  "git status",
];

export const DENY_COMMANDS = [
  "npx",
  "pnpx",
  "pnpm dlx",
  "npm i",
  "npm install",
  "yarn add",
  "pnpm i",
  "pnpm install",
  "pnpm add",
  "sudo",
  "chmod",
  "chown",
];

export function createPatterns(strings: string[]): RegExp[] {
  return strings.map(
    (s) => new RegExp(`\\b${s.replace(/\s+/g, "\\s+")}\\b`, "i"),
  );
}

export const ALLOW_PATTERNS = createPatterns(ALLOW_COMMANDS);
export const DENY_PATTERNS = createPatterns(DENY_COMMANDS);

export type EvalResult = "deny" | "ask" | "allow";

export function evaluateCommand(command: string): EvalResult {
  const isDenied = DENY_PATTERNS.some((pattern) => pattern.test(command));
  if (isDenied) {
    return "deny";
  }

  const isAllowed = ALLOW_PATTERNS.some((pattern) => pattern.test(command));
  if (isAllowed) {
    return "allow";
  }

  return "ask";
}
