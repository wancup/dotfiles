import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";
import { evaluateCommand } from "./permissions.ts";

export default function(pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (!isToolCallEventType("bash", event)) return;

    const command = event.input.command;
    const result = evaluateCommand(command);

    if (result === "deny") {
      if (ctx.hasUI) {
        ctx.ui.notify("Permission Denied!", "error");
      }
      return {
        block: true,
        reason: "安全上の理由により、このコマンドの実行は禁止されています。",
      };
    }

    if (result === "ask") {
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
