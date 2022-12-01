import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:share/share.dart';

import '../Ads/applifecyclereactor.dart';
import '../Ads/appopenadmanager.dart';

class PercentageOf extends StatefulWidget {
  @override
  _PercentageOfState createState() => _PercentageOfState();
}

class _PercentageOfState extends State<PercentageOf>
    with WidgetsBindingObserver {
  final formkey = GlobalKey<FormState>();
  final aValFocus = FocusNode();
  final bValFocus = FocusNode();
  double aVal = 0.0, bVal = 0.0, result = 0.0;

  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState;
    appOpenAdManager..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState;
    _appLifecycleReactor.listenToAppStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Percentage Of",
            style: TextStyle(
                fontFamily: 'SansSerif', fontWeight: FontWeight.w700)),
      ),
      body: Container(
        decoration: containerStyle(),
        child: Form(
            key: formkey,
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    focusNode: aValFocus,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(bValFocus),
                    validator: (val) {
                      if (val!.isEmpty)
                        return "Enter number";
                      else {
                        aVal = double.parse(val);
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: txtStyle(),
                    decoration: InputDecoration(
                      labelText: "Enter Value",
                      hintText: "Eg. 120",
                      hintStyle: txtFormHintStyle(),
                      labelStyle: txtFormLabelStyle(),
                      enabledBorder: txtFormLayoutStyle(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "is What Percentage of",
                    style: listTextStyle(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    focusNode: bValFocus,
                    validator: (val) {
                      if (val!.isEmpty)
                        return "Enter number";
                      else {
                        bVal = double.parse(val);
                        return null;
                      }
                    },
                    onEditingComplete: () {
                      if (formkey.currentState!.validate()) calculate();
                    },
                    keyboardType: TextInputType.number,
                    style: txtStyle(),
                    decoration: InputDecoration(
                      labelText: "Enter Value",
                      hintText: "Eg. 120",
                      hintStyle: txtFormHintStyle(),
                      labelStyle: txtFormLabelStyle(),
                      enabledBorder: txtFormLayoutStyle(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Text(
                          "Result :",
                          style: listTextStyle(),
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          alignment: Alignment.centerLeft,
                          height: conHeight,
                          decoration: resultWidget(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                result.toString().isEmpty
                                    ? "0.0"
                                    : result.toString(),
                                style: resultTextStyle(),
                              ),
                              Text(
                                "%",
                                style: resultTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NiceButton(
                        onPressed: () {
                          formkey.currentState!.reset();
                          FocusScope.of(context).requestFocus(aValFocus);
                          setState(() {
                            result = 0.0;
                          });
                        },
                        text: "Reset",
                        gradientColors: myGradient,
                        width: myWidth,
//                      style: resultTextStyle(),
                        padding: EdgeInsets.all(8.0),
                        background: Colors.blue,
                        fontSize: myFontSize,
                        elevation: myElevate,
                        radius: myRadius,
                      ),
                      NiceButton(
                        gradientColors: myGradient,
                        width: myWidth,
//                      style: resultTextStyle(),
                        padding: EdgeInsets.all(8.0),
                        background: Colors.blue,
                        elevation: myElevate, fontSize: myFontSize,
                        radius: myRadius,
                        onPressed: () {
                          if (formkey.currentState!.validate()) calculate();
                        },
                        text: "Calculate",
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 36.0),
        child: FloatingActionButton(
          elevation: 8.0,
          onPressed: () {
            if (formkey.currentState!.validate()) {
              Share.share(
                "$aVal is $result% of $bVal",
                subject: "Summary",
              );
            }
          },
          child: Icon(Icons.share),
        ),
      ),
    );
  }

  void calculate() {
    setState(() {
      result = perOf(aVal, bVal);
    });
  }
}
