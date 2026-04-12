import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";
import { resolve } from "node:path";
import { expandPath, extractPathsFromCommand, isForbiddenFile, isOutsideCwd, normalizePath } from "./path-utils.ts";

const PERMISSION_CHOICES = ["一回だけ許可", "セッション中は常に許可（このパス）", "拒否"] as const;

export default function(pi: ExtensionAPI) {
  const sessionAllowedPaths = new Set<string>();

  pi.on("session_start", async () => {
    sessionAllowedPaths.clear();
  });

  async function checkPath(
    filePath: string,
    cwd: string,
    toolName: string,
    ctx: ExtensionContext,
  ): Promise<{ block: true; reason: string } | void> {
    const resolved = resolve(cwd, expandPath(filePath));

    if (isForbiddenFile(resolved)) {
      if (ctx.hasUI) ctx.ui.notify(`Cannot Access!: ${filePath}`, "error");
      return { block: true, reason: `"${filePath}" はセンシティブなファイルのためアクセスが禁止されています` };
    }

    if (isOutsideCwd(resolved, cwd)) {
      if (sessionAllowedPaths.has(resolved)) return;

      if (!ctx.hasUI) {
        return { block: true, reason: `カレントディレクトリ外のファイルへのアクセスがブロックされました: ${filePath}` };
      }

      const choice = await ctx.ui.select(
        `カレントディレクトリ外へのアクセス\n\n`
          + `${toolName} が CWD 外のファイルにアクセスしようとしています:\n\n`
          + `  Resolved: ${resolved}\n  CWD: ${cwd}\n\n許可しますか？`,
        [...PERMISSION_CHOICES],
      );

      if (choice === "セッション中は常に許可（このパス）") {
        sessionAllowedPaths.add(resolved);
        return;
      }
      if (choice === "一回だけ許可") return;
      return { block: true, reason: "ユーザーによりブロックされました" };
    }

    return;
  }

  pi.on("tool_call", async (event, ctx) => {
    const cwd = ctx.cwd;

    if (["read", "write", "edit", "grep", "find", "ls"].includes(event.toolName)) {
      const input = event.input as Record<string, unknown>;
      const rawPath = (input.path ?? input.directory) as string | undefined;
      if (!rawPath) return;
      return checkPath(normalizePath(rawPath), cwd, event.toolName, ctx);
    }

    if (isToolCallEventType("bash", event)) {
      const command = event.input.command;
      if (!command) return;

      const paths = extractPathsFromCommand(command);
      for (const p of paths) {
        const result = await checkPath(p, cwd, "bash", ctx);
        if (result) return result;
      }
    }

    return;
  });
}
