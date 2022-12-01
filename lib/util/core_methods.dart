import 'package:flutter/material.dart';

//const String mainBgImage = "images/bg_main.png";
//const AssetImage bgAssetImage = AssetImage(mainBgImage);
ImageCache bgCacheImage = ImageCache();
const String bgImage = "images/bg.png";
const Color textColor = Color.fromRGBO(247, 247, 247, 1);
const double myRadius = 26.0, myElevate = 8.0, myWidth = 120, myFontSize = 16;
const List<Color> myGradient = [
  Colors.blue,
  Colors.green,
  Colors.white70,
];
const List<Color> myDiagGradient = [Colors.blue, Colors.green, Colors.black];
const double cardHeight = 50;
const double conHeight = 46;

double percentage(double per, double value) {
  return double.parse(((per / 100) * value).toStringAsFixed(2));
}

double perIncrease(double per, double val) {
  return double.parse((((val / 100) * per) + val).toStringAsFixed(2));
}

double perDecrease(double per, double val) {
  return double.parse((val - ((val / 100) * per)).toStringAsFixed(2));
}

Map<dynamic, double> perTip(double per, double val, double numOfPeople) {
  var perPersons = val / numOfPeople;
  var tipAmount = double.parse(((per * perPersons) / 100).toStringAsFixed(2));
  var totalPerPersons =
      double.parse((tipAmount + perPersons).toStringAsFixed(2));
  var totalToPay = totalPerPersons * numOfPeople;
//    List<double> result =[tipAmount,totalToPay,totalPerPersons];
  Map<dynamic, double> result = {
    "Tip Amount": tipAmount,
    "Total to Pay": totalToPay,
    "Total Per Persons": totalPerPersons
  };
  return result;
}

double perMargin(double cost, double margin) {
  var result = perIncrease(margin, cost);
  return result;
}

double perChange(double oldVal, double newVal) {
  var diff = newVal.abs() - oldVal;
  var result = diff / oldVal.abs();
  return double.parse((result * 100).toStringAsFixed(2));
}

double perOf(double val1, double val2) {
  return double.parse(((val1 / val2) * 100).toStringAsFixed(2));
}

OutlineInputBorder txtFormLayoutStyle() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide:
          BorderSide(color: Colors.blue, width: 2, style: BorderStyle.solid));
}

TextStyle txtFormHintStyle() {
  return TextStyle(fontSize: 12, color: Colors.white70);
}

TextStyle txtFormLabelStyle() {
  return TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontFamily: "sansserif",
      fontWeight: FontWeight.bold);
}

txtSuffixStyle() {
  return TextStyle(fontSize: 12, color: Colors.white, fontFamily: "Serif");
}

TextStyle txtStyle() {
  return TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontFamily: "sansserif",
      fontWeight: FontWeight.bold,
      height: 0.8);
}

BoxDecoration containerStyle() {
  return BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.blue, Colors.indigo, Colors.black],
          transform: GradientRotation(0.0)));
}

BoxDecoration mainBoxStyle() {
  return const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.black, Colors.indigo, Colors.blue],
          transform: GradientRotation(0.0)));
}

BoxDecoration aboutBoxStyle() {
  return const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.blue, Colors.black],
          transform: GradientRotation(8.0)));
}

BoxDecoration resultWidget() {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
      border:
          Border.all(color: Colors.blue, style: BorderStyle.solid, width: 2.0));
}

TextStyle listTextStyle() {
  return TextStyle(
      fontFamily: 'Serif',
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: textColor);
}

TextStyle resultTextStyle() {
  return TextStyle(
      fontFamily: 'Serif',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white);
}

TextStyle drawerListStyle() {
  return TextStyle(
      fontFamily: 'Serif',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.black);
}
