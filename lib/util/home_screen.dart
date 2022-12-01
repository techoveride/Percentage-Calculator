import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nice_button/nice_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:percentage_calculator/Ads/anchored_adaptive_ad.dart';
import 'package:percentage_calculator/model/about.dart';
import 'package:percentage_calculator/model/per_calculate.dart';
import 'package:percentage_calculator/model/per_change.dart';
import 'package:percentage_calculator/model/per_decrease.dart';
import 'package:percentage_calculator/model/per_increase.dart';
import 'package:percentage_calculator/model/per_margin.dart';
import 'package:percentage_calculator/model/per_of.dart';
import 'package:percentage_calculator/model/report_bug.dart';
import 'package:percentage_calculator/model/tip_calculate.dart';

import 'core_methods.dart';

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const int maxFailedLoadAttempts = 3;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final AdRequest request = AdRequest(
    nonPersonalizedAds: true,
  );
  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }
  // InterstitialAd? _interstitialAd;
  // int _numInterstitialLoadAttempts = 0;

  double adPadding = 0.0;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        InAppUpdate.startFlexibleUpdate().then((_) {
          setState(() {
            _flexibleUpdateAvailable = true;
          });
        }).catchError((e) {
          showSnack(e.toString());
        });
        if (_flexibleUpdateAvailable) {
          InAppUpdate.completeFlexibleUpdate().then((_) {
            showSnack("Success!");
          }).catchError((e) {
            showSnack(e.toString());
          });
        }
      }
    });
    // _createInterstitialAd();
    // Future.delayed(Duration(milliseconds: 1000)).then((value) {
    //   _showInterstitialAd();
    // });
  }

/*
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-2165165254805026/3440937708'
            // ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            if (kDebugMode) {
              print('$ad loaded');
            }
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      if (kDebugMode) {
        print('Warning: attempt to show interstitial before loaded.');
      }
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
*/

  @override
  void dispose() {
    // _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actions: [],
          elevation: 8.0,
          title: Text(
            "% Calculator",
            style: TextStyle(
                fontFamily: 'SansSerif',
                fontWeight: FontWeight.w800,
                fontSize: 22),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Image.asset(
                    "images/main_logo.png",
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.blue],
                        transform: GradientRotation(0.0))),
                accountName: Text(
                  "Techoveride",
                  style: resultTextStyle(),
                ),
                accountEmail: Text(
                  "admin@techoveride.com",
                  style: resultTextStyle(),
                ),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text(
                  "Share App",
                  style: drawerListStyle(),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.report),
                title: Text(
                  "Report Bug",
                  style: drawerListStyle(),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ReportBug();
                  }));
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text(
                  "About",
                  style: drawerListStyle(),
                ),
                onTap: () async {
                  String appVersion = "";
                  PackageInfo _packageInfo = await PackageInfo.fromPlatform();
                  setState(() {
                    appVersion = _packageInfo.version.toString();
                  });
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return About(appVersion: appVersion);
                  }));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app_outlined),
                title: Text(
                  "Exit",
                  style: drawerListStyle(),
                ),
                onTap: () => _onBackPressed(),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: mainBoxStyle(),
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => pageRouter(context, PercentageCalculate()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Colors.indigo,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(
                                'images/percentage.png',
                                fit: BoxFit.fill,
                                height: cardHeight,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: ListTile(
                              title: Text("Calculate Percentage ",
                                  style: listTextStyle()),
                              subtitle: Text(
                                "Discover percentage of any number",
                                style: txtFormHintStyle(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => pageRouter(context, PercentageIncrease()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Colors.indigo,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(
                                'images/per_increase.png',
                                fit: BoxFit.fill,
                                height: cardHeight,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: ListTile(
                              title: Text("Percentage Increase",
                                  style: listTextStyle()),
                              subtitle: Text(
                                "Increase a number by variable percentage propotions",
                                style: txtFormHintStyle(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => pageRouter(context, PercentageDecrease()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Colors.indigo,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/per_decrease.png',
                                fit: BoxFit.fill,
                                height: cardHeight,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: ListTile(
                              title: Text("Percentage Decrease",
                                  style: listTextStyle()),
                              subtitle: Text(
                                "Decrease a number by variable percentage propotions",
                                style: txtFormHintStyle(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => pageRouter(context, TipCalculate()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Colors.indigo,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/tip.png',
                                fit: BoxFit.fill,
                                height: cardHeight,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: ListTile(
                              title:
                                  Text("Calculate Tip", style: listTextStyle()),
                              subtitle: Text(
                                "Easily know the tip you are giving out ",
                                style: txtFormHintStyle(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => pageRouter(context, PercentageMargin()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Colors.indigo,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/per_margin.png',
                                fit: BoxFit.fill,
                                height: cardHeight,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: ListTile(
                              title: Text("Percentage Margin",
                                  style: listTextStyle()),
                              subtitle: Text(
                                "Calculate Margins of percentages",
                                style: txtFormHintStyle(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => pageRouter(context, PercentageChange()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Colors.indigo,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/per_change.png',
                                fit: BoxFit.fill,
                                height: cardHeight,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: ListTile(
                              title: Text("Percentage Change",
                                  style: listTextStyle()),
                              subtitle: Text(
                                "Keep Track of the increase or decrease a value has change by percentage",
                                style: txtFormHintStyle(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: InkWell(
                  onTap: () => pageRouter(context, PercentageOf()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Colors.indigo,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/per_of.png',
                                fit: BoxFit.fill,
                                height: cardHeight,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: ListTile(
                              title:
                                  Text("What's % of ", style: listTextStyle()),
                              subtitle: Text(
                                "Know what percentage is a value to another",
                                style: txtFormHintStyle(),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AnchoredAdaptiveAd(),
      ),
    );
  }

  pageRouter(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return route;
    }));
  }

  Future<bool> _onBackPressed() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Are You Sure ?"),
              content: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text("Do you want to exit"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        NiceButton(
                          gradientColors: myDiagGradient,
                          width: 76,
                          textColor: Colors.black,
                          icon: Icons.keyboard_return,
                          padding: EdgeInsets.all(8.0),
                          background: Colors.blue,
                          elevation: myElevate,
                          radius: myRadius,
                          fontSize: myFontSize,
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          text: "No",
                        ),
                        NiceButton(
                          gradientColors: myDiagGradient,
                          width: 76,
                          padding: EdgeInsets.all(8.0),
                          textColor: Colors.black,
                          background: Colors.blue,
                          icon: Icons.power_settings_new,
                          elevation: myElevate,
                          radius: myRadius,
                          fontSize: myFontSize,
                          onPressed: () {
                            // Navigator.of(context).pop(true);
                            if (Platform.isAndroid) {
                              SystemChannels.platform
                                  .invokeMethod("SystemNavigator.pop");
                              exit(0);
                            } else {
                              SystemChannels.platform
                                  .invokeMethod("SystemNavigator.pop");
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Thank You!")));
                          },
                          text: "Yes",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              elevation: 4.0,
              contentPadding: EdgeInsets.all(10.0),
              shape: BeveledRectangleBorder(
                  side: BorderSide(color: Colors.indigoAccent, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0)),
            ));

    return Future(() => false);
  }
}
