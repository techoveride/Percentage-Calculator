import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  static bool isLoaded = false;

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: "ca-app-pub-2165165254805026/6522356999",
      // adUnitId: "ca-app-pub-3940256099942544/3419835294",
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print("Ad Loaded.................................");
          }
          _appOpenAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          // Handle the error.
        },
      ),
    );
  }

  // Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (kDebugMode) {
      print(
          "Called=====================================================================");
    }
    if (_appOpenAd == null) {
      if (kDebugMode) {
        print('Tried to show ad before available.');
      }
      loadAd();
      return;
    }
    if (_isShowingAd) {
      if (kDebugMode) {
        print('Tried to show ad while already showing an ad.');
      }
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        if (kDebugMode) {
          print('$ad onAdShowedFullScreenContent');
        }
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        if (kDebugMode) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
        }
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        if (kDebugMode) {
          print('$ad onAdDismissedFullScreenContent');
        }
        _isShowingAd = false;

        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}
