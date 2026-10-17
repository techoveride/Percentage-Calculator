# Optional: Claude backend for the AI assistant

The app uses **free Gemini** by default (see `docs/AI_SETUP.md`). This folder is
the optional paid upgrade: a Cloudflare Worker (free plan) that keeps a Claude
API key secret, enforces daily limits on the server, and calls **Claude Haiku
5.5**. No Firebase Blaze plan needed.

Limits (change in `wrangler.toml` → `[vars]`): 3 questions/day free, +5 per rewarded
ad (max 2 ads/day), 30/day ad-free, 5,000/day across all users (protects your bill).

## 1. Accounts (one time)

1. **Claude API key**: https://platform.claude.com → sign up → *Billing* (add a
   card and a monthly spend limit, e.g. $10) → *API keys* → create a key.
2. **Cloudflare**: sign up free at https://dash.cloudflare.com.

## 2. Deploy (from `server/ai-worker`)

```bash
npm install
npx wrangler login                       # opens the browser once
npx wrangler d1 create percal-ai         # copy the printed database_id
#   → paste it into wrangler.toml (database_id = "...")
npm run db:migrate                       # creates the usage table
npx wrangler secret put ANTHROPIC_API_KEY   # paste the Claude key when asked
npm run deploy                           # prints https://percal-ai.<you>.workers.dev
```

## 3. Firebase App Check (free on the Spark plan)

The Worker only answers requests from the genuine app.

1. Firebase console → project **percalculator** → *App Check* → *Apps* →
   Android app `com.techoveride.percentagecalculator` → **Play Integrity** → enter
   the **SHA-256 of the app signing key** (Play Console → *Test and release* →
   *App integrity* → *App signing key certificate*). Save.
2. Do **not** turn on "Enforce" for other Firebase products — not needed.
3. Testing a debug build: run it once, find `App Check debug token` in logcat,
   and add it under *App Check → Apps → ⋮ → Manage debug tokens*.

## 4. Switch the app to it (no app update)

Firebase console → *Remote Config*: set **`ai_provider` = `worker`** and
**`ai_endpoint` = `https://percal-ai.<you>.workers.dev`** (and `ai_enabled` =
true) → Publish. Update the privacy page's section 4 to describe Anthropic
before switching.

## 5. Play Console

*App content → Data safety*, add these as **collected and shared** (sent to
Anthropic through your server), purpose **App functionality**, **optional**
(only when the user uses the AI assistant), **encrypted in transit**:

- **App activity → Other user-generated content** (the questions)
- **Financial info → Other financial info** (amounts in saved calculations)

The privacy page already describes this (section 4).

## Costs

Claude Haiku 5.5: $0.10 per million input tokens, $0.50 per million output.
A typical question (≈3,000 tokens in, ≈600 out incl. tool calls) ≈ **$0.0006**;
1,000 questions ≈ $0.60. Cloudflare Workers + D1 free tiers cover 100,000
requests/day.

## Local checks

```bash
npm run typecheck && npm test            # 19 tests, fake Claude API, no cost
```
