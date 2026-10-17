import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_config.dart';
import 'ads_controller.dart';

enum RewardOutcome {
  /// The user watched the ad: grant the reward.
  earned,

  /// The ad was closed before the reward.
  skipped,

  /// No ad could be loaded (offline, no fill, no consent, not configured).
  unavailable,
}

/// Rewarded video ads: the user chooses to watch one to unlock an extra.
class RewardedAdManager {
  RewardedAdManager._();

  static final RewardedAdManager instance = RewardedAdManager._();

  static const _loadTimeout = Duration(seconds: 8);

  RewardedAd? _ad;
  Completer<void>? _loading;

  /// Starts loading so the ad is ready when the user taps "Watch ad".
  void preload() {
    if (_ad != null || _loading != null) return;
    final adUnitId = AdConfig.rewardedAdUnitId;
    if (adUnitId == null || !AdsController.instance.adsReady.value) return;

    final loading = _loading = Completer<void>();
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _loading = null;
          loading.complete();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          _loading = null;
          loading.complete();
        },
      ),
    );
  }

  /// Shows a rewarded ad, loading one first (up to a few seconds) if needed.
  Future<RewardOutcome> show() async {
    if (_ad == null) {
      preload();
      final loading = _loading;
      if (loading != null) {
        await loading.future.timeout(_loadTimeout, onTimeout: () {});
      }
    }
    final ad = _ad;
    if (ad == null) return RewardOutcome.unavailable;
    _ad = null;

    final result = Completer<RewardOutcome>();
    var earned = false;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (!result.isCompleted) {
          result.complete(
            earned ? RewardOutcome.earned : RewardOutcome.skipped,
          );
        }
        preload();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Rewarded ad failed to show: $error');
        ad.dispose();
        if (!result.isCompleted) result.complete(RewardOutcome.unavailable);
        preload();
      },
    );
    await ad.show(onUserEarnedReward: (_, _) => earned = true);
    return result.future;
  }
}
