import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percentage_calculator/util/home_screen.dart';

import 'firebase_options.dart';

void main() {
  runApp(MyApp());
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MobileAds.instance.initialize();

  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: [
        'A1D024014755730901F48A2A06933E1F',
        '0D7F74813DAA8CF871287A05BE47FDE7'
      ]));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Percentage Calculator",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
//      theme: ThemeData.dark(),
    );
  }
}
