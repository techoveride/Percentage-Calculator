import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:share/share.dart';

class PercentageIncrease extends StatefulWidget {
  @override
  _PercentageIncreaseState createState() => _PercentageIncreaseState();
}

class _PercentageIncreaseState extends State<PercentageIncrease> {
  final formkey = GlobalKey<FormState>();
  final valFocus = FocusNode();
  final perFocus = FocusNode();
  double value, percent, result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Percentage Increase",
            style: TextStyle(
                fontFamily: 'SansSerif', fontWeight: FontWeight.w700)),
      ),
      body: Container(
        decoration: containerStyle(),
        child: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Text(
                      "Amount :",
                      style: listTextStyle(),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: Container(
                      child: TextFormField(
                        focusNode: valFocus,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(perFocus),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter Amount";
                          } else {
                            value = double.parse(val);
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Text(
                        "Increase by : ",
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
                            if (val.isEmpty) {
                              return "Enter Percentage";
                            } else {
                              percent = double.parse(val);
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
                        "Result :",
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
                            result != null ? result.toString() : "0.0",
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
                      elevation: myElevate, fontSize: myFontSize,
                      radius: myRadius,
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
                      elevation: myElevate, fontSize: myFontSize,
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
                "$value increased by $percent% = $result",
                subject: "Summary",
              );
            }
          },
          child: Icon(Icons.share),
        ),
      ),
    );
  }

  calculate() {
    setState(() {
      result = perIncrease(percent, value);
    });
  }
}
