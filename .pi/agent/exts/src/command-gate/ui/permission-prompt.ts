import type { SafetyReview } from "../review/safety-review.ts";

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

export function buildPermissionPrompt(command: string, review: SafetyReview): string {
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
