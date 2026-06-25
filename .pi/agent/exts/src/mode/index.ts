import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";
import { notifyStatus } from "../_shared/notify-status.ts";

type ChatMode = "normal" | "edit";

const PERMISSION_CHOICES = ["一回だけ許可", "許可してeditモードに入る", "却下"] as const;

function describeMutationRequest(path: string): string {
  return [
    "normalモード中にファイルを作成・編集しようとしています。",
    `ファイル: ${path}`,
  ].join("\n");
}

export default function modeExtension(pi: ExtensionAPI): void {
  let mode: ChatMode = "normal";

  function setMode(
    nextMode: ChatMode,
    ctx: ExtensionContext,
  ): void {
    mode = nextMode;
    if (mode === "edit") {
      ctx.ui.setStatus("mode", ctx.ui.theme.fg("accent", "[EDIT]"));
      return;
    }

    ctx.ui.setStatus("mode", ctx.ui.theme.fg("muted", "[NORMAL]"));
  }

  pi.registerShortcut("shift+tab", {
    description: "Toggle mode",
    handler: async (ctx) => {
      const nextMode = mode === "normal" ? "edit" : "normal";
      setMode(nextMode, ctx);
    },
  });

  pi.on("session_start", async (_event, ctx) => {
    setMode("edit", ctx);
  });

  pi.on("tool_call", async (event, ctx) => {
    if (mode === "edit") return;
    if (!isToolCallEventType("edit", event) && !isToolCallEventType("write", event)) return;

    if (!ctx.hasUI) {
      return {
        block: true,
        reason: "normalモードではファイル変更前に確認が必要",
      };
    }

    notifyStatus("waiting");
    const choice = await ctx.ui.select(
      describeMutationRequest(event.input.path),
      [...PERMISSION_CHOICES],
    );

    if (choice === "一回だけ許可") {
      return;
    }

    if (choice === "許可してeditモードに入る") {
      setMode("edit", ctx);
      return;
    }

    return {
      block: true,
      reason:
        `ユーザーによりファイル変更が却下されました: ${event.input.path}。ファイル操作をおこなわず、方針だけ提示してください。`,
    };
  });
}
