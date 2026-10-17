// Exact maths for the AI. The model never does arithmetic itself: it calls
// these tools, which run here in code on the history the app sent.
import type Anthropic from "@anthropic-ai/sdk";
import type { HistoryEntry } from "./schema";

export const TOOLS: Anthropic.Tool[] = [
  {
    name: "aggregate",
    description:
      "Exact total / average / minimum / maximum / count of one number across the user's saved " +
      "calculations. Matches a field by its label (an input or a result label exactly as shown in " +
      "the history). Optionally restrict to one calculator and/or a date range (inclusive, YYYY-MM-DD).",
    strict: true,
    input_schema: {
      type: "object",
      properties: {
        op: { type: "string", enum: ["sum", "avg", "min", "max", "count"] },
        label: { type: "string", description: "Input or result label, e.g. \"You save\"." },
        calculator: {
          type: ["string", "null"],
          description: "Calculator id from the history (e.g. \"discount\"), or null for all.",
        },
        from: { type: ["string", "null"], description: "Start date YYYY-MM-DD, or null." },
        to: { type: ["string", "null"], description: "End date YYYY-MM-DD, or null." },
      },
      required: ["op", "label", "calculator", "from", "to"],
      additionalProperties: false,
    },
  },
  {
    name: "compute",
    description:
      "Exactly evaluates an arithmetic expression with numbers, + - * / ^ and parentheses, " +
      "e.g. \"(1250 - 980) / 980 * 100\". Use it for every calculation you need.",
    strict: true,
    input_schema: {
      type: "object",
      properties: { expression: { type: "string" } },
      required: ["expression"],
      additionalProperties: false,
    },
  },
];

export interface AggregateInput {
  op: "sum" | "avg" | "min" | "max" | "count";
  label: string;
  calculator: string | null;
  from: string | null;
  to: string | null;
}

/** Runs a tool call; returns a JSON string for the tool_result. */
export function runTool(name: string, input: unknown, history: HistoryEntry[]): string {
  try {
    if (name === "aggregate") return JSON.stringify(aggregate(input as AggregateInput, history));
    if (name === "compute") {
      const expression = String((input as { expression?: unknown }).expression ?? "");
      return JSON.stringify({ expression, value: round(evaluate(expression)) });
    }
    return JSON.stringify({ error: `Unknown tool ${name}` });
  } catch (e) {
    return JSON.stringify({ error: e instanceof Error ? e.message : String(e) });
  }
}

export function aggregate(input: AggregateInput, history: HistoryEntry[]) {
  const label = input.label.trim().toLowerCase();
  const values: number[] = [];
  for (const entry of history) {
    if (input.calculator && entry.calculator !== input.calculator) continue;
    const day = entry.date.slice(0, 10);
    if (input.from && day < input.from) continue;
    if (input.to && day > input.to) continue;
    const field = [...entry.inputs, ...entry.results].find(
      (f) => f.label.trim().toLowerCase() === label,
    );
    if (field) values.push(field.value);
  }
  if (values.length === 0) return { op: input.op, label: input.label, count: 0, value: null };
  let value: number;
  switch (input.op) {
    case "sum": value = values.reduce((a, b) => a + b, 0); break;
    case "avg": value = values.reduce((a, b) => a + b, 0) / values.length; break;
    case "min": value = Math.min(...values); break;
    case "max": value = Math.max(...values); break;
    case "count": value = values.length; break;
  }
  return { op: input.op, label: input.label, count: values.length, value: round(value) };
}

function round(v: number): number {
  return Math.round(v * 1e6) / 1e6;
}

/** Safe arithmetic evaluator (no eval): numbers, + - * / ^, parentheses, unary minus. */
export function evaluate(expression: string): number {
  if (expression.length > 300) throw new Error("Expression too long");
  const src = expression.replace(/\s+/g, "");
  let pos = 0;

  const peek = () => src[pos];
  const expect = (ch: string) => {
    if (src[pos] !== ch) throw new Error(`Expected "${ch}" at ${pos}`);
    pos++;
  };

  function number(): number {
    const match = /^\d+(\.\d+)?|^\.\d+/.exec(src.slice(pos));
    if (!match) throw new Error(`Number expected at ${pos}`);
    pos += match[0].length;
    return parseFloat(match[0]);
  }

  function primary(): number {
    if (peek() === "(") {
      pos++;
      const v = additive();
      expect(")");
      return v;
    }
    if (peek() === "-") {
      pos++;
      return -primary();
    }
    if (peek() === "+") {
      pos++;
      return primary();
    }
    return number();
  }

  function power(): number {
    const base = primary();
    if (peek() === "^") {
      pos++;
      return Math.pow(base, power()); // right-associative
    }
    return base;
  }

  function multiplicative(): number {
    let v = power();
    while (peek() === "*" || peek() === "/") {
      const op = src[pos++];
      const rhs = power();
      if (op === "/" && rhs === 0) throw new Error("Division by zero");
      v = op === "*" ? v * rhs : v / rhs;
    }
    return v;
  }

  function additive(): number {
    let v = multiplicative();
    while (peek() === "+" || peek() === "-") {
      const op = src[pos++];
      const rhs = multiplicative();
      v = op === "+" ? v + rhs : v - rhs;
    }
    return v;
  }

  const result = additive();
  if (pos !== src.length) throw new Error(`Unexpected "${src[pos]}" at ${pos}`);
  if (!Number.isFinite(result)) throw new Error("Result is not a finite number");
  return result;
}
