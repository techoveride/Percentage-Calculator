import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../premium/ad_free.dart';
import 'ad_config.dart';
import 'ads_controller.dart';

/// Anchored adaptive banner for a Scaffold's `bottomNavigationBar`.
///
/// Takes no space until an ad has loaded, waits for consent/SDK init, and
/// reloads when the available width changes (e.g. rotation).
class AnchoredAdaptiveAd extends StatefulWidget {
  const AnchoredAdaptiveAd({super.key});

  @override
  State<AnchoredAdaptiveAd> createState() => _AnchoredAdaptiveAdState();
}

class _AnchoredAdaptiveAdState extends State<AnchoredAdaptiveAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  int? _requestedWidth;

  @override
  void initState() {
    super.initState();
    AdsController.instance.adsReady.addListener(_maybeLoad);
    AdFreeController.instance.addListener(_onAdFreeChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maybeLoad();
  }

  @override
  void dispose() {
    AdsController.instance.adsReady.removeListener(_maybeLoad);
    AdFreeController.instance.removeListener(_onAdFreeChanged);
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Hides the banner the moment the user goes ad-free (purchase or 24-hour
  /// pass) and brings it back when a pass runs out.
  void _onAdFreeChanged() {
    if (!mounted) return;
    if (!AdFreeController.instance.active) {
      _requestedWidth = null;
      _maybeLoad();
      return;
    }
    if (_bannerAd == null) return;
    _bannerAd?.dispose();
    setState(() {
      _bannerAd = null;
      _isLoaded = false;
      _requestedWidth = null;
    });
  }

  void _maybeLoad() {
    if (!mounted ||
        !AdsController.instance.adsReady.value ||
        AdFreeController.instance.active) {
      return;
    }
    // Depend on the screen size only (not insets/padding, which change often
    // while the keyboard or system bars animate) so the ad reloads only when
    // the device is rotated or the window is resized.
    final width = MediaQuery.sizeOf(context).width.truncate();
    if (width <= 0 || width == _requestedWidth) return;
    _requestedWidth = width;
    _loadAd(width);
  }

  Future<void> _loadAd(int width) async {
    final adUnitId = AdConfig.bannerAdUnitId;
    if (adUnitId == null) return;

    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (!mounted || size == null || width != _requestedWidth) return;

    final oldAd = _bannerAd;
    setState(() {
      _bannerAd = null;
      _isLoaded = false;
    });
    await oldAd?.dispose();

    final ad = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted || !identical(ad, _bannerAd)) {
            ad.dispose();
            return;
          }
          setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner failed to load: $error');
          ad.dispose();
          if (mounted && identical(ad, _bannerAd)) {
            setState(() => _bannerAd = null);
          }
        },
      ),
    );
    _bannerAd = ad;
    await ad.load();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;
    if (ad == null || !_isLoaded) return const SizedBox.shrink();
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SafeArea(
        top: false,
        child: Center(
          heightFactor: 1,
          child: SizedBox(
            width: ad.size.width.toDouble(),
            height: ad.size.height.toDouble(),
            child: AdWidget(ad: ad),
          ),
        ),
      ),
    );
  }
}
