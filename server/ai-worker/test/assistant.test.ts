// Runs the real assistant against a fake Claude API (no network, no cost).
import Anthropic from "@anthropic-ai/sdk";
import { describe, expect, it } from "vitest";

import { AiError, createAssistant, MODEL } from "../src/assistant";
import type { HistoryEntry } from "../src/schema";

type Body = Record<string, unknown> & { messages: Anthropic.MessageParam[] };

function fakeClaude(responses: Array<Partial<Anthropic.Message>>) {
  const requests: Body[] = [];
  const fetch = async (_url: string | URL | Request, init?: RequestInit) => {
    requests.push(JSON.parse(String(init?.body)) as Body);
    const next = responses.shift();
    if (!next) throw new Error("No more fake responses");
    const message = {
      id: `msg_${requests.length}`,
      type: "message",
      role: "assistant",
      model: MODEL,
      stop_sequence: null,
      usage: { input_tokens: 10, output_tokens: 10 },
      ...next,
    };
    return new Response(JSON.stringify(message), {
      status: 200,
      headers: { "content-type": "application/json" },
    });
  };
  const client = new Anthropic({ apiKey: "test", fetch, maxRetries: 0 });
  return { client, requests };
}

const history: HistoryEntry[] = [
  {
    date: "2026-10-02T09:00:00",
    calculator: "discount",
    title: "Discount",
    inputs: [
      { label: "Original price", value: 80, suffix: "" },
      { label: "Discount", value: 25, suffix: "%" },
    ],
    results: [
      { label: "Final price", value: 60, suffix: "" },
      { label: "You save", value: 20, suffix: "" },
    ],
  },
  {
    date: "2026-10-05T09:00:00",
    calculator: "discount",
    title: "Discount",
    inputs: [
      { label: "Original price", value: 200, suffix: "" },
      { label: "Discount", value: 10, suffix: "%" },
    ],
    results: [
      { label: "Final price", value: 180, suffix: "" },
      { label: "You save", value: 20, suffix: "" },
    ],
  },
];

describe("assistant", () => {
  it("runs the aggregate tool in code and returns the structured answer", async () => {
    const { client, requests } = fakeClaude([
      {
        stop_reason: "tool_use",
        content: [
          { type: "thinking", thinking: "", signature: "sig-1" } as Anthropic.ContentBlock,
          {
            type: "tool_use",
            id: "toolu_1",
            name: "aggregate",
            input: { op: "sum", label: "You save", calculator: "discount", from: null, to: null },
          } as Anthropic.ContentBlock,
        ],
      },
      {
        stop_reason: "end_turn",
        content: [
          {
            type: "text",
            text: JSON.stringify({ kind: "answer", answer: "You saved 40 with discounts.", steps: [] }),
            citations: null,
          } as Anthropic.ContentBlock,
        ],
      },
    ]);
    const assistant = createAssistant(client, () => new Date("2026-10-17T00:00:00Z"));

    const result = await assistant.assist({
      locale: "en",
      question: "How much did I save?",
      history,
      calculators: [],
    });

    expect(result).toEqual({ kind: "answer", answer: "You saved 40 with discounts.", steps: [] });
    expect(requests).toHaveLength(2);

    const first = requests[0]!;
    expect(first.model).toBe("claude-haiku-5-5");
    expect(first.output_config).toMatchObject({ effort: "low", format: { type: "json_schema" } });
    expect(String((first.messages[0]!.content as string))).toContain("Today is 2026-10-17");

    // Second request: assistant turn echoed (thinking kept) + exact tool result.
    const second = requests[1]!;
    const assistantTurn = second.messages[1]!;
    expect(assistantTurn.role).toBe("assistant");
    expect((assistantTurn.content as Array<{ type: string }>).map((b) => b.type)).toEqual([
      "thinking",
      "tool_use",
    ]);
    const toolResult = (second.messages[2]!.content as Anthropic.ToolResultBlockParam[])[0]!;
    expect(toolResult.tool_use_id).toBe("toolu_1");
    expect(JSON.parse(String(toolResult.content))).toEqual({
      op: "sum",
      label: "You save",
      count: 2,
      value: 40,
    });
  });

  it("turns a refusal into AiError('refused')", async () => {
    const { client } = fakeClaude([
      {
        stop_reason: "refusal",
        stop_details: { type: "refusal", category: null, explanation: "declined" },
        content: [],
      } as Partial<Anthropic.Message>,
    ]);
    const error = await createAssistant(client)
      .explain({ locale: "en", calculation: history[0]! })
      .catch((e: unknown) => e);
    expect(error).toBeInstanceOf(AiError);
    expect((error as AiError).code).toBe("refused");
  });

  it("passes the calculator's formula to explain", async () => {
    const { client, requests } = fakeClaude([
      {
        stop_reason: "end_turn",
        content: [
          { type: "text", text: JSON.stringify({ explanation: "x" }), citations: null } as Anthropic.ContentBlock,
        ],
      },
    ]);
    await createAssistant(client).explain({ locale: "fr", calculation: history[0]! });
    const prompt = String(requests[0]!.messages[0]!.content);
    expect(prompt).toContain("you save = price × discount / 100");
    expect(prompt).toContain('"fr"');
  });
});
