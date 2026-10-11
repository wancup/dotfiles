import type { ExtensionContext } from "@earendil-works/pi-coding-agent";
import { Text } from "@earendil-works/pi-tui";
import type { SafetyReview } from "../review/safety-review.ts";

// 枠・選択肢・操作案内・フッターなどの表示領域をまとめて確保する。
const RESERVED_UI_ROWS = 16;
const COMMAND_ELLIPSIS = "-- (省略) --";

export interface TerminalSize {
  columns: number;
  rows: number;
}

export function resolveTerminalSize(
  mode: ExtensionContext["mode"],
  columns?: number,
  rows?: number,
): TerminalSize {
  if (
    mode === "tui"
    && columns !== undefined && Number.isInteger(columns) && columns > 0
    && rows !== undefined && Number.isInteger(rows) && rows > 0
  ) {
    return { columns, rows };
  }
  return { columns: 80, rows: 48 };
}

export function classificationLabel(classification: SafetyReview["classification"]): string {
  switch (classification) {
    case "safe":
      return "安全";
    case "caution":
      return "注意";
    case "dangerous":
      return "危険";
    case "unknown":
      return "不明";
  }
}

export function formatSafetyReviewDetails(review: SafetyReview): string {
  return [
    `コマンドの説明: ${review.commandDescription}`,
    "",
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
    "",
    formatSafetyReviewDetails(review),
    "",
    "実行を許可しますか？",
  ].join("\n");
}

type PromptMessage = string;
type ErrorMessage = string;
export function buildPermissionPrompt(
  command: string,
  review: SafetyReview,
  size: TerminalSize,
): [PromptMessage, null] | [null, ErrorMessage] {
  const maxRows = size.rows - RESERVED_UI_ROWS;
  const countRows = (prompt: string) => new Text(prompt, 1, 0).render(size.columns).length;
  const fullPrompt = formatPermissionPrompt(command, review);
  if (countRows(fullPrompt) <= maxRows) return [fullPrompt, null];

  const omittedPrompt = formatPermissionPrompt(COMMAND_ELLIPSIS, review);
  const commandRows = maxRows - countRows(omittedPrompt);
  if (commandRows < 0) {
    return [null, "確認画面の表示領域が不足しているため、コマンドの実行を拒否しました。"];
  }

  const preview = new Text(command, 0, 0).render(Math.max(1, size.columns - 2))
    .slice(0, commandRows)
    .map((line) => line.trimEnd())
    .join("\n");
  return [formatPermissionPrompt(preview ? `${preview}\n${COMMAND_ELLIPSIS}` : COMMAND_ELLIPSIS, review), null];
}
