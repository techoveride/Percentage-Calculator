import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:share/share.dart';

class PercentageMargin extends StatefulWidget {
  @override
  _PercentageMarginState createState() => _PercentageMarginState();
}

class _PercentageMarginState extends State<PercentageMargin> {
  final formkey = GlobalKey<FormState>();
  final valFocus = FocusNode();
  final perFocus = FocusNode();
  double cost, margin, result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Percentage Margin",
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
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Text(
                        "Cost : ",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: TextFormField(
                        focusNode: valFocus,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(perFocus);
                        },
                        validator: (val) {
                          if (val.isEmpty)
                            return "Enter Cost";
                          else {
                            cost = double.parse(val);
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
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Text(
                        "Margin :",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: Container(
                        child: TextFormField(
                          focusNode: perFocus,
                          onEditingComplete: () {
                            if (formkey.currentState.validate()) calculate();
                          },
                          validator: (val) {
                            if (val.isEmpty)
                              return "Enter Margin";
                            else {
                              margin = double.parse(val);
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          style: txtStyle(),
                          decoration: InputDecoration(
                            labelText: "Enter Percentage",
                            hintText: "Eg. 10",
                            hintStyle: txtFormHintStyle(),
                            labelStyle: txtFormLabelStyle(),
                            suffixText: "%",
                            suffixStyle: txtSuffixStyle(),
                            enabledBorder: txtFormLayoutStyle(),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Text(
                        "Price : ",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: conHeight,
                        decoration: resultWidget(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            result == null ? "0.0" : result.toString(),
                            style: resultTextStyle(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NiceButton(
                      gradientColors: myGradient,
                      width: myWidth,
//                      style: resultTextStyle(),
                      padding: EdgeInsets.all(8.0),
                      background: Colors.blue,
                      elevation: myElevate,
                      radius: myRadius,
                      fontSize: myFontSize,
                      onPressed: () {
                        if (formkey.currentState.validate()) calculate();
                      },
                      text: "Calculate",
                    ),
                    NiceButton(
                      onPressed: () {
                        formkey.currentState.reset();
                        FocusScope.of(context).requestFocus(valFocus);
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
                      elevation: myElevate,
                      fontSize: myFontSize,
                      radius: myRadius,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 36.0),
        child: FloatingActionButton(
          elevation: 8.0,
          onPressed: () {
            if (formkey.currentState.validate()) {
              Share.share(
                "Cost of $cost with Margin of $margin \n Price= $result",
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
      result = perMargin(cost, margin);
      print("$result");
    });
  }
}
