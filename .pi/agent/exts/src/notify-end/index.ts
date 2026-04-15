import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { notifyStatus } from "../_shared/notify-status";

export default function(pi: ExtensionAPI) {
  pi.on("agent_end", async (_event, _ctx) => {
    notifyStatus("finish");
  });
}
