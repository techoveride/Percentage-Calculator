-- Daily AI usage per app install (and one '__global__' row per day).
-- Only counters are stored: no questions, history or personal data.
CREATE TABLE IF NOT EXISTS usage (
  install_id TEXT NOT NULL,
  day        TEXT NOT NULL,          -- UTC date, YYYY-MM-DD
  used       INTEGER NOT NULL DEFAULT 0,
  rewards    INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (install_id, day)
);
