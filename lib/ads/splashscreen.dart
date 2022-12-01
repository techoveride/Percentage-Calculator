import 'package:flutter/material.dart';

import '../ads/appopenadmanager.dart';
import '../util/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  @override
  void initState() {
    super.initState();

    //Load AppOpen Ad
    appOpenAdManager.loadAd();

    //Show AppOpen Ad After 8 Seconds
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      //Here we will wait for 8 seconds to load our ad
      //After 8 second it will go to HomePage
      appOpenAdManager.showAdIfAvailable();
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      // navigatorKey.currentState.pop();
    });
    // appOpenAdManager.showAdIfAvailable();
    // Navigator.pop(context);
    // globals.appOpenAdStatus.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
