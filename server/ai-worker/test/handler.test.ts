import Anthropic from "@anthropic-ai/sdk";
import { describe, expect, it } from "vitest";

import { AiError, type Assistant } from "../src/assistant";
import { handle, type Deps } from "../src/index";
import { GLOBAL_ID, MemoryUsageStore } from "../src/quota";

const limits = { free: 3, premium: 30, rewardBonus: 5, maxRewards: 2, global: 1000 };
const install = "test-install-0001";

function deps(overrides: Partial<Deps> = {}): Deps & { calls: string[] } {
  const calls: string[] = [];
  const assistant: Assistant = {
    assist: async ({ question }) => {
      calls.push(`assist:${question}`);
      return { kind: "answer", answer: "ok", steps: [] };
    },
    insights: async () => {
      calls.push("insights");
      return { insights: [{ title: "T", text: "X" }] };
    },
    explain: async () => {
      calls.push("explain");
      return { explanation: "E" };
    },
  };
  return {
    assistant,
    store: new MemoryUsageStore(),
    verifyAppCheck: async (token) => token === "valid",
    limits,
    now: () => new Date("2026-10-17T12:00:00Z"),
    calls,
    ...overrides,
  };
}

const post = (path: string, body: unknown, token: string | null = "valid") =>
  new Request(`https://ai.example${path}`, {
    method: "POST",
    headers: token ? { "X-Firebase-AppCheck": token } : {},
    body: JSON.stringify(body),
  });

const ask = (premium = false) => ({
  installId: install,
  premium,
  locale: "en",
  question: "How much did I save?",
  history: [],
  calculators: [],
});

describe("handler", () => {
  it("rejects requests without a valid App Check token", async () => {
    const d = deps();
    expect((await handle(post("/v1/assist", ask(), null), d)).status).toBe(401);
    expect((await handle(post("/v1/assist", ask(), "forged"), d)).status).toBe(401);
    expect(d.calls).toEqual([]);
  });

  it("validates the body", async () => {
    const res = await handle(post("/v1/assist", { installId: "x" }), deps());
    expect(res.status).toBe(400);
  });

  it("allows 3 free questions a day, then returns 429 with the quota", async () => {
    const d = deps();
    for (let i = 0; i < 3; i++) {
      const res = await handle(post("/v1/assist", ask()), d);
      expect(res.status).toBe(200);
      const body = (await res.json()) as { quota: { remaining: number } };
      expect(body.quota.remaining).toBe(2 - i);
    }
    const blocked = await handle(post("/v1/assist", ask()), d);
    expect(blocked.status).toBe(429);
    expect(await blocked.json()).toMatchObject({
      ok: false,
      error: "quota",
      quota: { remaining: 0, limit: 3, rewardsLeft: 2 },
    });
    expect(d.calls).toHaveLength(3);
  });

  it("adds 5 questions per rewarded ad, at most twice a day", async () => {
    const d = deps();
    const reward = () => handle(post("/v1/reward", { installId: install }), d);
    expect(await (await reward()).json()).toMatchObject({ quota: { limit: 8, rewardsLeft: 1 } });
    expect(await (await reward()).json()).toMatchObject({ quota: { limit: 13, rewardsLeft: 0 } });
    const third = await reward();
    expect(third.status).toBe(400);
    expect(await third.json()).toMatchObject({ error: "no_rewards_left" });
  });

  it("gives ad-free users 30 a day and no rewards", async () => {
    const res = await handle(post("/v1/quota", { installId: install, premium: true }), deps());
    expect(await res.json()).toEqual({
      ok: true,
      quota: { used: 0, limit: 30, remaining: 30, rewardsLeft: 0 },
    });
  });

  it("does not count failed AI calls", async () => {
    const d = deps();
    d.assistant.assist = async () => {
      throw new AiError("refused", "no");
    };
    const res = await handle(post("/v1/assist", ask()), d);
    expect(res.status).toBe(422);
    expect(await res.json()).toMatchObject({ error: "refused", quota: { used: 0 } });
    expect((await d.store.get(install, "2026-10-17")).used).toBe(0);
  });

  it("maps Claude rate limits to 'busy'", async () => {
    const d = deps();
    d.assistant.insights = async () => {
      throw new Anthropic.RateLimitError(429, { type: "error" }, "rate limited", new Headers());
    };
    const res = await handle(
      post("/v1/insights", {
        installId: install,
        history: [{ date: "2026-10-01", calculator: "tip", title: "Tip", inputs: [], results: [] }],
      }),
      d,
    );
    expect(res.status).toBe(503);
    expect(await res.json()).toMatchObject({ error: "busy" });
  });

  it("stops everyone once the global daily cap is reached", async () => {
    const d = deps({ limits: { ...limits, global: 2 } });
    await d.store.addUse(GLOBAL_ID, "2026-10-17");
    await d.store.addUse(GLOBAL_ID, "2026-10-17");
    const res = await handle(post("/v1/assist", ask(true)), d);
    expect(res.status).toBe(503);
    expect(d.calls).toEqual([]);
  });

  it("only answers POST /v1/*", async () => {
    const res = await handle(new Request("https://ai.example/", { method: "GET" }), deps());
    expect(res.status).toBe(404);
  });
});
