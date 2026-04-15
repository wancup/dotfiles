import { execSync } from "node:child_process";

export function notifyStatus(status: "waiting" | "finish"): void {
  try {
    execSync(`wezterm cli set-tab-title status:${status}`, { stdio: "ignore" });
  } catch (e) {
    console.warn("[Notify Status] Failed to set wezterm title!", e);
  }
}
