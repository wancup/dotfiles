import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";
import { evaluateCommand } from "./permissions.ts";

const PERMISSION_CHOICES = [
  "一回だけ許可",
  "セッション中は常に許可",
  "拒否",
] as const;

export default function(pi: ExtensionAPI) {
  const sessionAllowedCommands = new Set<string>();

  pi.on("session_start", async () => {
    sessionAllowedCommands.clear();
  });

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
      if (sessionAllowedCommands.has(command)) {
        return;
      }

      if (!ctx.hasUI) {
        return {
          block: true,
          reason: "UIによる許可を求められなため、危険なコマンドとして拒否しました。",
        };
      }

      const choice = await ctx.ui.select(
        `以下のコマンドを実行しようとしています:\n\n\`\`\`bash\n${command}\n\`\`\`\n\n実行を許可しますか？`,
        [...PERMISSION_CHOICES],
      );

      if (choice === "セッション中は常に許可") {
        sessionAllowedCommands.add(command);
        return;
      }

      if (choice === "一回だけ許可") {
        return;
      }

      return {
        block: true,
        reason: "ユーザーによって危険なコマンドとして拒否されました。",
      };
    }
  });
}
