import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
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
const String testDevice = 'D3E0FD831CF53C8B3EA7798C1AD0128D';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  static String mainBgImage = "images/bg_main.png";
//  static AssetImage bgAssetImage = AssetImage(mainBgImage);
//  Image backgroundImage;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['calculator', 'money', 'finance', 'shopping'],
    // contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-2165165254805026/4144884404',
      //test id
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.fullBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: 'ca-app-pub-2165165254805026/6196332674',
      //test id
      // adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-2165165254805026~5996187976");
    //load and show banner
    _bannerAd = createBannerAd()..load();
    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show();
    //load Interstitial Ad
    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();
    //show intertitial timer
    Timer(Duration(seconds: 120), () {
      _interstitialAd?.show();
    });
//    backgroundImage = Image.asset(mainBgImage);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
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
                  "techoveride@admin.net",
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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return About();
                  }));
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: mainBoxStyle(),
//        decoration: BoxDecoration(
//            image: DecorationImage(
//          image: bgAssetImage,
//          fit: BoxFit.fill,
//        )),
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
      ),
    );
  }

  pageRouter(BuildContext context, Object route) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return route;
    }));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
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
                            Navigator.of(context).pop(true);
                            Scaffold.of(context).showSnackBar(
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
  }
}
