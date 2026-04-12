import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";

const _ASK_COMMANDS = [
  "rm -rf",
  "rm -f",
];
const _DENY_COMMANDS = [
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

function createPatterns(strings: string[]): RegExp[] {
  return strings.map(
    (s) => new RegExp(`\\b${s.replace(/\s+/g, "\\s+")}\\b`, "i"),
  );
}

const ASK_PATTERNS = createPatterns(_ASK_COMMANDS);
const DENY_PATTERNS = createPatterns(_DENY_COMMANDS);

export default function(pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (!isToolCallEventType("bash", event)) return;

    const command = event.input.command;

    const isDenied = DENY_PATTERNS.some((pattern) => pattern.test(command));
    if (isDenied) {
      if (ctx.hasUI) {
        ctx.ui.notify(
          "Permission Denied!",
          "error",
        );
      }

      return {
        block: true,
        reason: "安全上の理由により、このコマンドの実行は禁止されています。",
      };
    }

    const shouldAsk = ASK_PATTERNS.some((pattern) => pattern.test(command));
    if (shouldAsk) {
      if (!ctx.hasUI) {
        return {
          block: true,
          reason: "UIによる許可を求められなため、危険なコマンドとして拒否しました。",
        };
      }

      const ok = await ctx.ui.confirm(
        "Permission Asking",
        `以下のコマンドを実行しようとしています:\n\n\`\`\`bash\n${command}\n\`\`\`\n\n実行を許可しますか？`,
      );

      if (!ok) {
        return {
          block: true,
          reason: "ユーザーによって危険なコマンドとして拒否されました。",
        };
      }
    }
  });
}
