// Percentage Calculator AI backend (Cloudflare Worker).
//
// POST /v1/assist   – question about history, or a calculation in words
// POST /v1/insights – 2–4 insights about the history
// POST /v1/explain  – step-by-step explanation of one calculation
// POST /v1/reward   – +5 questions after a rewarded ad (max 2 a day)
// POST /v1/quota    – remaining questions today
//
// Every request needs a valid Firebase App Check token (X-Firebase-AppCheck).
import Anthropic from "@anthropic-ai/sdk";
import type * as z from "zod/v4";

import { firebaseAppCheckVerifier, type AppCheckVerifier } from "./appcheck";
import { AiError, createAssistant, type Assistant } from "./assistant";
import {
  D1UsageStore,
  daysAgo,
  GLOBAL_ID,
  status,
  today,
  type Limits,
  type QuotaStatus,
  type UsageStore,
} from "./quota";
import { AssistRequest, ExplainRequest, InsightsRequest, QuotaRequest } from "./schema";

export interface Env {
  ANTHROPIC_API_KEY: string;
  DB: D1Database;
  FIREBASE_PROJECT_NUMBER: string;
  FIREBASE_APP_IDS: string;
  FREE_DAILY: string;
  PREMIUM_DAILY: string;
  REWARD_BONUS: string;
  MAX_REWARDS_PER_DAY: string;
  GLOBAL_DAILY: string;
}

export interface Deps {
  assistant: Assistant;
  store: UsageStore;
  verifyAppCheck: AppCheckVerifier;
  limits: Limits;
  now?: () => Date;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    return handle(request, {
      assistant: createAssistant(new Anthropic({ apiKey: env.ANTHROPIC_API_KEY })),
      store: new D1UsageStore(env.DB),
      verifyAppCheck: firebaseAppCheckVerifier(
        env.FIREBASE_PROJECT_NUMBER,
        env.FIREBASE_APP_IDS.split(",").map((s) => s.trim()),
      ),
      limits: {
        free: Number(env.FREE_DAILY),
        premium: Number(env.PREMIUM_DAILY),
        rewardBonus: Number(env.REWARD_BONUS),
        maxRewards: Number(env.MAX_REWARDS_PER_DAY),
        global: Number(env.GLOBAL_DAILY),
      },
    });
  },

  // Cron (wrangler.toml): delete usage counters older than 7 days.
  async scheduled(_controller: ScheduledController, env: Env): Promise<void> {
    await new D1UsageStore(env.DB).deleteBefore(daysAgo(7));
  },
} satisfies ExportedHandler<Env>;

type ErrorCode =
  | "not_found"
  | "unauthorized"
  | "bad_request"
  | "quota"
  | "no_rewards_left"
  | "busy"
  | "refused"
  | "upstream";

const json = (status: number, body: unknown) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { "content-type": "application/json; charset=utf-8" },
  });

const fail = (status: number, error: ErrorCode, quota?: QuotaStatus) =>
  json(status, { ok: false, error, ...(quota ? { quota } : {}) });

export async function handle(request: Request, deps: Deps): Promise<Response> {
  const url = new URL(request.url);
  const route = url.pathname.replace(/\/+$/, "");
  if (request.method !== "POST" || !route.startsWith("/v1/")) return fail(404, "not_found");

  if (!(await deps.verifyAppCheck(request.headers.get("X-Firebase-AppCheck")))) {
    return fail(401, "unauthorized");
  }

  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return fail(400, "bad_request");
  }

  const day = today(deps.now?.() ?? new Date());

  switch (route) {
    case "/v1/quota": {
      const req = QuotaRequest.safeParse(body);
      if (!req.success) return fail(400, "bad_request");
      const row = await deps.store.get(req.data.installId, day);
      return json(200, { ok: true, quota: status(row, req.data.premium, deps.limits) });
    }

    case "/v1/reward": {
      const req = QuotaRequest.safeParse(body);
      if (!req.success) return fail(400, "bad_request");
      const row = await deps.store.get(req.data.installId, day);
      const current = status(row, req.data.premium, deps.limits);
      if (current.rewardsLeft <= 0) return fail(400, "no_rewards_left", current);
      await deps.store.addReward(req.data.installId, day);
      const updated = { ...row, rewards: row.rewards + 1 };
      return json(200, { ok: true, quota: status(updated, req.data.premium, deps.limits) });
    }

    case "/v1/assist":
      return withQuota(body, AssistRequest, day, deps, (r) =>
        deps.assistant.assist({
          locale: r.locale,
          question: r.question,
          history: r.history,
          calculators: r.calculators,
        }),
      );

    case "/v1/insights":
      return withQuota(body, InsightsRequest, day, deps, (r) =>
        deps.assistant.insights({ locale: r.locale, history: r.history }),
      );

    case "/v1/explain":
      return withQuota(body, ExplainRequest, day, deps, (r) =>
        deps.assistant.explain({ locale: r.locale, calculation: r.calculation }),
      );

    default:
      return fail(404, "not_found");
  }
}

/** Checks the daily limits, runs [work], and counts it only if it succeeded. */
async function withQuota<S extends z.ZodType<{ installId: string; premium: boolean }>>(
  body: unknown,
  schema: S,
  day: string,
  deps: Deps,
  work: (req: z.infer<S>) => Promise<unknown>,
): Promise<Response> {
  const parsed = schema.safeParse(body);
  if (!parsed.success) return fail(400, "bad_request");
  const req = parsed.data;

  const row = await deps.store.get(req.installId, day);
  const before = status(row, req.premium, deps.limits);
  if (before.remaining <= 0) return fail(429, "quota", before);

  const global = await deps.store.get(GLOBAL_ID, day);
  if (global.used >= deps.limits.global) return fail(503, "busy", before);

  let data: unknown;
  try {
    data = await work(req);
  } catch (error) {
    if (error instanceof AiError) {
      return fail(error.code === "refused" ? 422 : 502, error.code === "refused" ? "refused" : "upstream", before);
    }
    if (error instanceof Anthropic.RateLimitError) return fail(503, "busy", before);
    if (error instanceof Anthropic.APIError) {
      console.error(`Claude API error ${error.status}: ${error.message}`);
      return fail(502, "upstream", before);
    }
    throw error;
  }

  await deps.store.addUse(req.installId, day);
  await deps.store.addUse(GLOBAL_ID, day);
  const after = status({ ...row, used: row.used + 1 }, req.premium, deps.limits);
  return json(200, { ok: true, data, quota: after });
}
