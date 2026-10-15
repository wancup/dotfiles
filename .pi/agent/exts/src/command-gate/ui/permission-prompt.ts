import type { ExtensionContext } from "@earendil-works/pi-coding-agent";
import { Text } from "@earendil-works/pi-tui";
import type { SafetyReview } from "../review/safety-review.ts";

const MAX_COMMAND_ROWS = 24;
const COMMAND_ELLIPSIS = "-- (省略) --";

export function resolveTerminalColumns(
  mode: ExtensionContext["mode"],
  columns?: number,
): number {
  if (mode === "tui" && columns !== undefined && Number.isInteger(columns) && columns > 0) {
    return columns;
  }
  return 80;
}

export function classificationLabel(classification: SafetyReview["classification"]): string {
  switch (classification) {
    case "safe":
      return "安全";
    case "dangerous":
      return "危険";
    case "unknown":
      return "不明";
  }
}

export function formatSafetyReviewDetails(review: SafetyReview): string {
  return [
    `コマンドの説明: ${review.commandDescription}`,
    `分類の根拠: ${review.classificationReason}`,
  ].join("\n");
}

function formatPermissionPrompt(command: string, review: SafetyReview): string {
  return [
    "以下のコマンドを実行しようとしています:",
    "",
    "```bash",
    command,
    "```",
    "",
    `AI判定: ${classificationLabel(review.classification)}`,
    formatSafetyReviewDetails(review),
    "",
    "実行を許可しますか？",
  ].join("\n");
}

export function buildPermissionPrompt(
  command: string,
  review: SafetyReview,
  columns: number,
): string {
  const commandRows = new Text(command, 0, 0).render(Math.max(1, columns - 2));
  if (commandRows.length <= MAX_COMMAND_ROWS) return formatPermissionPrompt(command, review);

  const preview = commandRows
    .slice(0, MAX_COMMAND_ROWS)
    .map((line) => line.trimEnd())
    .join("\n");
  return formatPermissionPrompt(`${preview}\n${COMMAND_ELLIPSIS}`, review);
}
