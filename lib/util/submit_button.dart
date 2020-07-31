//import 'package:flutter/material.dart';
//import 'package:nice_button/nice_button.dart';
//import 'package:percentage_calculator/model/per_calculate.dart';
//
//class SubmitButton extends StatefulWidget {
//  @override
//  _SubmitButtonState createState() => _SubmitButtonState();
//}
//
//class _SubmitButtonState extends State<SubmitButton> {
//  final double radius = 42.0;
//
//  final formkey = GlobalKey<FormState>();
//  double result;
//
//  @override
//  Widget build(BuildContext context) {
//    return NiceButton(
//      gradientColors: [Colors.blue, Colors.green, Colors.white70],
//      width: 180,
////                      style: resultTextStyle(),
//      padding: EdgeInsets.all(12.0),
//      background: Colors.blue,
//      elevation: 8.0,
//      radius: radius,
//      onPressed: () {
//        if (formkey.currentState.validate()) {
//          setState(() {});
//          PercentageCalculate.changeState();
//        }
//      },
//      text: "Calculate",
//    );
//  }
//}
