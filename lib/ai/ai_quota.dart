import 'package:shared_preferences/shared_preferences.dart';

/// Daily AI allowance.
class AiQuota {
  const AiQuota({
    required this.used,
    required this.limit,
    required this.remaining,
    required this.rewardsLeft,
  });

  factory AiQuota.fromJson(Map<String, dynamic> json) => AiQuota(
    used: (json['used'] as num).toInt(),
    limit: (json['limit'] as num).toInt(),
    remaining: (json['remaining'] as num).toInt(),
    rewardsLeft: (json['rewardsLeft'] as num).toInt(),
  );

  final int used;
  final int limit;
  final int remaining;
  final int rewardsLeft;
}

/// Daily limits kept on the device (used with the free Gemini backend; the
/// Claude Worker enforces the same limits on the server).
class LocalAiQuota {
  static const freeDaily = 3;
  static const premiumDaily = 30;
  static const rewardBonus = 5;
  static const maxRewards = 2;

  static const _dayKey = 'ai_quota_day';
  static const _usedKey = 'ai_quota_used';
  static const _rewardsKey = 'ai_quota_rewards';

  LocalAiQuota({DateTime Function()? now}) : _now = now ?? DateTime.now;

  final DateTime Function() _now;

  String get _today => _now().toIso8601String().substring(0, 10);

  Future<(int used, int rewards)> _read() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_dayKey) != _today) return (0, 0); // new day
    return (prefs.getInt(_usedKey) ?? 0, prefs.getInt(_rewardsKey) ?? 0);
  }

  Future<void> _write(int used, int rewards) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dayKey, _today);
    await prefs.setInt(_usedKey, used);
    await prefs.setInt(_rewardsKey, rewards);
  }

  static AiQuota statusOf(int used, int rewards, {required bool premium}) {
    final limit = premium ? premiumDaily : freeDaily + rewards * rewardBonus;
    return AiQuota(
      used: used,
      limit: limit,
      remaining: (limit - used).clamp(0, limit),
      rewardsLeft: premium ? 0 : (maxRewards - rewards).clamp(0, maxRewards),
    );
  }

  Future<AiQuota> status({required bool premium}) async {
    final (used, rewards) = await _read();
    return statusOf(used, rewards, premium: premium);
  }

  Future<AiQuota> addUse({required bool premium}) async {
    final (used, rewards) = await _read();
    await _write(used + 1, rewards);
    return statusOf(used + 1, rewards, premium: premium);
  }

  /// Returns null when no rewarded bonus is left today.
  Future<AiQuota?> addReward({required bool premium}) async {
    final (used, rewards) = await _read();
    if (premium || rewards >= maxRewards) return null;
    await _write(used, rewards + 1);
    return statusOf(used, rewards + 1, premium: premium);
  }
}
