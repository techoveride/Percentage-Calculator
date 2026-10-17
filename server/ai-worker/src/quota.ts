// Daily AI limits per app install, stored in Cloudflare D1 (counters only).

export interface UsageRow {
  used: number;
  rewards: number;
}

export interface UsageStore {
  get(installId: string, day: string): Promise<UsageRow>;
  addUse(installId: string, day: string): Promise<void>;
  addReward(installId: string, day: string): Promise<void>;
}

export interface Limits {
  free: number;
  premium: number;
  rewardBonus: number;
  maxRewards: number;
  global: number;
}

export const GLOBAL_ID = "__global__";

export interface QuotaStatus {
  used: number;
  limit: number;
  remaining: number;
  rewardsLeft: number;
}

export function status(row: UsageRow, premium: boolean, limits: Limits): QuotaStatus {
  const limit = premium ? limits.premium : limits.free + row.rewards * limits.rewardBonus;
  return {
    used: row.used,
    limit,
    remaining: Math.max(0, limit - row.used),
    rewardsLeft: premium ? 0 : Math.max(0, limits.maxRewards - row.rewards),
  };
}

export function today(now = new Date()): string {
  return now.toISOString().slice(0, 10);
}

export class D1UsageStore implements UsageStore {
  constructor(private readonly db: D1Database) {}

  async get(installId: string, day: string): Promise<UsageRow> {
    const row = await this.db
      .prepare("SELECT used, rewards FROM usage WHERE install_id = ? AND day = ?")
      .bind(installId, day)
      .first<UsageRow>();
    return row ?? { used: 0, rewards: 0 };
  }

  async addUse(installId: string, day: string): Promise<void> {
    await this.db
      .prepare(
        "INSERT INTO usage (install_id, day, used) VALUES (?, ?, 1) " +
          "ON CONFLICT (install_id, day) DO UPDATE SET used = used + 1",
      )
      .bind(installId, day)
      .run();
  }

  async addReward(installId: string, day: string): Promise<void> {
    await this.db
      .prepare(
        "INSERT INTO usage (install_id, day, rewards) VALUES (?, ?, 1) " +
          "ON CONFLICT (install_id, day) DO UPDATE SET rewards = rewards + 1",
      )
      .bind(installId, day)
      .run();
  }

  /** Deletes counters for days before [day] (privacy policy: kept 7 days). */
  async deleteBefore(day: string): Promise<void> {
    await this.db.prepare("DELETE FROM usage WHERE day < ?").bind(day).run();
  }
}

/** The UTC date [days] days before [now], YYYY-MM-DD. */
export function daysAgo(days: number, now = new Date()): string {
  return today(new Date(now.getTime() - days * 24 * 60 * 60 * 1000));
}

/** In-memory store for tests and local experiments. */
export class MemoryUsageStore implements UsageStore {
  private readonly rows = new Map<string, UsageRow>();

  private row(installId: string, day: string): UsageRow {
    const key = `${installId}|${day}`;
    let row = this.rows.get(key);
    if (!row) {
      row = { used: 0, rewards: 0 };
      this.rows.set(key, row);
    }
    return row;
  }

  async get(installId: string, day: string): Promise<UsageRow> {
    return { ...this.row(installId, day) };
  }

  async addUse(installId: string, day: string): Promise<void> {
    this.row(installId, day).used++;
  }

  async addReward(installId: string, day: string): Promise<void> {
    this.row(installId, day).rewards++;
  }
}
