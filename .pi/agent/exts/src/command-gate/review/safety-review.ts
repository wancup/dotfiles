export type SafetyClassification = "safe" | "caution" | "dangerous" | "unknown";

export type SafetyReview = {
  classification: SafetyClassification;
  commandDescription: string;
  classificationReason: string;
};

export const DEFAULT_UNKNOWN_COMMAND_DESCRIPTION = "コマンドの動作内容を確認できませんでした。";
export const DEFAULT_UNKNOWN_CLASSIFICATION_REASON = "AIによる安全性判定結果を解析できませんでした。";

export function fallbackReview(classificationReason: string): SafetyReview {
  return {
    classification: "unknown",
    commandDescription: DEFAULT_UNKNOWN_COMMAND_DESCRIPTION,
    classificationReason,
  };
}

function extractJsonCandidate(text: string): string {
  const codeFenceMatch = text.match(/```(?:json)?\s*([\s\S]*?)```/i);
  if (codeFenceMatch?.[1]) {
    return codeFenceMatch[1].trim();
  }

  const firstBrace = text.indexOf("{");
  const lastBrace = text.lastIndexOf("}");
  if (firstBrace !== -1 && lastBrace > firstBrace) {
    return text.slice(firstBrace, lastBrace + 1);
  }

  return text.trim();
}

function normalizeClassification(value: unknown): SafetyClassification {
  if (typeof value !== "string") return "unknown";

  switch (value.trim().toLowerCase()) {
    case "safe":
    case "安全":
      return "safe";
    case "caution":
    case "warning":
    case "warn":
    case "注意":
      return "caution";
    case "dangerous":
    case "danger":
    case "unsafe":
    case "危険":
      return "dangerous";
    case "unknown":
    case "不明":
      return "unknown";
    default:
      return "unknown";
  }
}

function extractRequiredString(value: unknown): string | undefined {
  if (typeof value !== "string") return undefined;

  const trimmed = value.trim();
  return trimmed.length > 0 ? trimmed : undefined;
}

export function parseSafetyReview(text: string): SafetyReview {
  try {
    const parsed = JSON.parse(extractJsonCandidate(text)) as Record<string, unknown>;
    const commandDescription = extractRequiredString(parsed.commandDescription);
    const classificationReason = extractRequiredString(parsed.classificationReason);

    if (!commandDescription || !classificationReason) {
      return fallbackReview(DEFAULT_UNKNOWN_CLASSIFICATION_REASON);
    }

    return {
      classification: normalizeClassification(parsed.classification),
      commandDescription,
      classificationReason,
    };
  } catch {
    return fallbackReview(DEFAULT_UNKNOWN_CLASSIFICATION_REASON);
  }
}
