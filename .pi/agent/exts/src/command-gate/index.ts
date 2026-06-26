import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";
import { notifyStatus } from "../_shared/notify-status.ts";
import { evaluateCommand } from "./core/deny.ts";
import { reviewCommandSafety } from "./review/ai-reviewer.ts";
import { buildPermissionPrompt, classificationLabel } from "./ui/permission-prompt.ts";

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

    if (sessionAllowedCommands.has(command)) {
      return;
    }

    const review = await reviewCommandSafety(command, ctx);

    if (review.classification === "safe") {
      return;
    }

    if (!ctx.hasUI) {
      return {
        block: true,
        reason: `AI判定が「${
          classificationLabel(review.classification)
        }」のため、実行前の確認が必要ですが、UIによる許可を求められないため拒否しました。\n\n${review.description}`,
      };
    }

    notifyStatus("waiting");
    const choice = await ctx.ui.select(
      buildPermissionPrompt(command, review),
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
      reason: `ユーザーによって危険または不明なコマンドとして拒否されました。\n\n${review.description}`,
    };
  });
}
