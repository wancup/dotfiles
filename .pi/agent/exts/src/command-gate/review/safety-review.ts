export type SafetyClassification = "safe" | "dangerous" | "unknown";

export type SafetyReview = {
  classification: SafetyClassification;
  description: string;
};

export const DEFAULT_UNKNOWN_DESCRIPTION = "AIによる安全性判定結果を解析できませんでした。";

export function fallbackReview(description: string): SafetyReview {
  return {
    classification: "unknown",
    description,
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

function extractDescription(value: Record<string, unknown>): string {
  const candidates = [value.description, value.explanation, value.reason, value.summary];

  for (const candidate of candidates) {
    if (typeof candidate === "string" && candidate.trim().length > 0) {
      return candidate.trim();
    }
  }

  return DEFAULT_UNKNOWN_DESCRIPTION;
}

export function parseSafetyReview(text: string): SafetyReview {
  try {
    const parsed = JSON.parse(extractJsonCandidate(text)) as Record<string, unknown>;
    return {
      classification: normalizeClassification(parsed.classification ?? parsed.safety ?? parsed.result),
      description: extractDescription(parsed),
    };
  } catch {
    return {
      classification: "unknown",
      description: DEFAULT_UNKNOWN_DESCRIPTION,
    };
  }
}
