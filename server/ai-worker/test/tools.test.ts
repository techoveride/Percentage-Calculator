import { describe, expect, it } from "vitest";

import type { HistoryEntry } from "../src/schema";
import { aggregate, evaluate, runTool } from "../src/tools";

const entry = (calculator: string, date: string, saved: number): HistoryEntry => ({
  date,
  calculator,
  title: "Discount",
  inputs: [{ label: "Original price", value: saved * 4, suffix: "" }],
  results: [
    { label: "Final price", value: saved * 3, suffix: "" },
    { label: "You save", value: saved, suffix: "" },
  ],
});

const history = [
  entry("discount", "2026-09-30T10:00:00", 10),
  entry("discount", "2026-10-02T10:00:00", 20),
  entry("discount", "2026-10-15T10:00:00", 30.5),
  entry("tip", "2026-10-03T10:00:00", 99),
];

describe("evaluate", () => {
  it("follows precedence and parentheses", () => {
    expect(evaluate("2 + 3 * 4")).toBe(14);
    expect(evaluate("(1250 - 980) / 980 * 100")).toBeCloseTo(27.5510204, 6);
    expect(evaluate("-2^2")).toBe(4); // unary minus binds tighter here: (-2)^2
    expect(evaluate("2^3^2")).toBe(512); // right-associative
    expect(evaluate(".5 * 4")).toBe(2);
  });

  it("rejects anything that isn't arithmetic", () => {
    expect(() => evaluate("process.exit()")).toThrow();
    expect(() => evaluate("1 / 0")).toThrow("Division by zero");
    expect(() => evaluate("2 +")).toThrow();
    expect(() => evaluate("(1 + 2")).toThrow();
  });
});

describe("aggregate", () => {
  it("sums one label within a calculator and date range", () => {
    expect(
      aggregate({ op: "sum", label: "you save", calculator: "discount", from: "2026-10-01", to: "2026-10-31" }, history),
    ).toEqual({ op: "sum", label: "you save", count: 2, value: 50.5 });
  });

  it("supports avg/min/max/count across calculators", () => {
    const base = { label: "You save", calculator: null, from: null, to: null };
    expect(aggregate({ ...base, op: "count" }, history).value).toBe(4);
    expect(aggregate({ ...base, op: "max" }, history).value).toBe(99);
    expect(aggregate({ ...base, op: "min" }, history).value).toBe(10);
    expect(aggregate({ ...base, op: "avg", calculator: "discount" }, history).value).toBeCloseTo(20.166667, 5);
  });

  it("returns null when nothing matches", () => {
    expect(aggregate({ op: "sum", label: "Nope", calculator: null, from: null, to: null }, history)).toEqual({
      op: "sum",
      label: "Nope",
      count: 0,
      value: null,
    });
  });
});

describe("runTool", () => {
  it("returns errors as data instead of throwing", () => {
    expect(JSON.parse(runTool("compute", { expression: "1/0" }, []))).toEqual({ error: "Division by zero" });
    expect(JSON.parse(runTool("nope", {}, []))).toEqual({ error: "Unknown tool nope" });
    expect(JSON.parse(runTool("compute", { expression: "0.1 + 0.2" }, []))).toEqual({
      expression: "0.1 + 0.2",
      value: 0.3,
    });
  });
});

describe("daysAgo", () => {
  it("returns the UTC date N days earlier", async () => {
    const { daysAgo } = await import("../src/quota");
    expect(daysAgo(7, new Date("2026-10-17T02:00:00Z"))).toBe("2026-10-10");
    expect(daysAgo(7, new Date("2026-03-03T12:00:00Z"))).toBe("2026-02-24");
  });
});
