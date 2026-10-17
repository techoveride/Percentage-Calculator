# Turning on the AI assistant (free, Gemini)

The app's AI assistant (Ask, Smart input, Explain, Insights) uses **Google Gemini
through Firebase AI Logic** — free on the Spark plan, no server, no API key in
the app. It stays hidden until you switch it on in Remote Config, so no app
update is needed to turn it on or off.

## 1. Enable Firebase AI Logic (about 2 minutes)

1. Firebase console → project **percalculator** → *Build → AI Logic* →
   **Get started**.
2. Choose **Gemini Developer API** (the free option — no billing needed) and
   follow the prompts. Firebase creates the Gemini API key for you; it never
   goes into the app.

## 2. Protect it with App Check (free)

1. Firebase console → *App Check* → *Apps* → Android app
   `com.techoveride.percentagecalculator` → **Play Integrity** → paste the
   **SHA-256 of the app signing key** (Play Console → *Test and release* →
   *App integrity* → *App signing key certificate*) → Save.
2. *App Check → APIs* → **Firebase AI Logic** → **Enforce** (only after the
   Play Integrity step above and a build with App Check is live, otherwise
   older builds can't use the AI).
3. Testing a debug build: run it once, copy `App Check debug token` from
   logcat, and add it under *App Check → Apps → ⋮ → Manage debug tokens*.

## 3. Switch it on

Firebase console → *Remote Config* → set **`ai_enabled` = true** → Publish.
Apps pick it up on their next launch (within about an hour).

| Remote Config key | Default | Meaning |
|---|---|---|
| `ai_enabled` | `false` | Show the AI assistant |
| `ai_model` | `gemini-3.5-flash-lite` | Gemini model; change it here if Google retires it |
| `ai_provider` | `gemini` | `gemini` (free) or `worker` (Claude, paid — see `server/ai-worker/DEPLOY.md`) |
| `ai_endpoint` | *(empty)* | Worker URL when `ai_provider` = `worker` |

Daily limits are kept on the device: 3 questions/day free, +5 per rewarded ad
(twice a day), 30/day ad-free.

## Things to know about the free tier

- **Rate limits:** the free tier allows a limited number of requests per
  minute and per day for the whole app. If it's exceeded, users see "The AI
  assistant is busy". Firebase console → *AI Logic* shows usage.
- **Data use:** on Gemini's free tier Google may use prompts to improve its
  products, and human reviewers may read them. The consent screen asks users
  not to type personal information, and the privacy page (section 4) says so.
- **Regions:** Gemini's free tier isn't offered in every country. Users there
  see "The AI assistant isn't available right now". Moving the project to the
  Blaze plan (paid tier) removes both the data-use clause and most regional
  limits — or switch `ai_provider` to `worker` for Claude.

## Play Console → Data safety

Add as **collected and shared**, purpose **App functionality**, **optional**,
**encrypted in transit**:

- **App activity → Other user-generated content** (the questions)
- **Financial info → Other financial info** (amounts in saved calculations)
