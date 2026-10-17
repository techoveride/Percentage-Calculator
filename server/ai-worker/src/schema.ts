// Request and response shapes shared with the app (lib/ai/ai_service.dart).
import * as z from "zod/v4";

const Field = z.object({
  label: z.string().max(80),
  value: z.number().finite(),
  suffix: z.string().max(8).default(""),
});

export const HistoryEntrySchema = z.object({
  date: z.string().max(40), // ISO 8601
  calculator: z.string().max(30),
  title: z.string().max(80),
  inputs: z.array(Field).max(5),
  results: z.array(Field).max(6),
});
export type HistoryEntry = z.infer<typeof HistoryEntrySchema>;

const CalculatorSpec = z.object({
  calculator: z.string().max(30),
  title: z.string().max(80),
  fields: z.array(z.object({ label: z.string().max(80), suffix: z.string().max(8).default("") })).max(5),
  results: z.array(z.string().max(80)).max(6),
});

const Base = z.object({
  installId: z.string().min(8).max(64).regex(/^[A-Za-z0-9-]+$/),
  premium: z.boolean().default(false),
  locale: z.string().min(2).max(10).default("en"),
});

export const AssistRequest = Base.extend({
  question: z.string().min(1).max(500),
  history: z.array(HistoryEntrySchema).max(100).default([]),
  calculators: z.array(CalculatorSpec).max(20),
});

export const InsightsRequest = Base.extend({
  history: z.array(HistoryEntrySchema).min(1).max(100),
});

export const ExplainRequest = Base.extend({
  calculation: HistoryEntrySchema,
});

export const QuotaRequest = Base;

// ---- What the model returns (structured outputs) ---------------------------

export const AssistOutput = z.object({
  kind: z.enum(["answer", "calculation"]),
  answer: z.string(),
  steps: z.array(
    z.object({
      calculator: z.string(),
      inputs: z.array(
        z.object({
          value: z.number().nullable(),
          from_step: z.number().int().nullable(),
          result_index: z.number().int().nullable(),
        }),
      ),
    }),
  ),
});

export const InsightsOutput = z.object({
  insights: z.array(z.object({ title: z.string(), text: z.string() })),
});

export const ExplainOutput = z.object({
  explanation: z.string(),
});
