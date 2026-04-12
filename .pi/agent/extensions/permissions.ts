import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";

const ASK_PATTERNS = [
  /\brm\s+-rf\b/i,
  /\brm\s+-f\b/i,
];

const DENY_PATTERNS = [
  /\bnpx\b/i,
  /\bpnpx\b/i,
  /\bpnpm\s+dlx\b/i,
  /\bnpm\s+i\b/i,
  /\bnpm\s+install\b/i,
  /\byarn\s+add\b/i,
  /\bpnpm\s+i\b/i,
  /\bpnpm\s+install\b/i,
  /\bpnpm\s+add\b/i,
  /\bsudo\b/i,
  /\bchmod\b/i,
  /\bchown\b/i,
];

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
