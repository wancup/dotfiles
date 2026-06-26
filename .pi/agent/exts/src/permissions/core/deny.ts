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

export const DENY_PATTERNS = createPatterns(DENY_COMMANDS);

export type EvalResult = "deny" | "ask";

export function containsDeniedCommand(command: string): boolean {
  return DENY_PATTERNS.some((pattern) => pattern.test(command));
}

export function evaluateCommand(command: string): EvalResult {
  if (containsDeniedCommand(command)) {
    return "deny";
  }

  return "ask";
}
