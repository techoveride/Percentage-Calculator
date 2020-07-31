import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:share/share.dart';

class PercentageCalculate extends StatefulWidget {
  @override
  _PercentageCalculateState createState() => _PercentageCalculateState();
}

class _PercentageCalculateState extends State<PercentageCalculate> {
  final formkey = GlobalKey<FormState>();
  double result, value, percent;

  final perFocus = FocusNode();

  FocusNode valFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calculate Percentage",
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
                    flex: 2,
                    child: Text(
                      "What is : ",
                      style: listTextStyle(),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Container(
                      child: TextFormField(
                        style: txtStyle(),
                        focusNode: perFocus,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(valFocus);
                        },
                        validator: (val) {
                          if (val.isNotEmpty) {
                            percent = double.parse(val);
                            return null;
                          } else
                            return "Enter Percentage";
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Enter Percentage",
                          hintText: "Eg. 10",
                          hintStyle: txtFormHintStyle(),
                          labelStyle: txtFormLabelStyle(),
                          suffixText: "% of",
                          suffixStyle: txtSuffixStyle(),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Text(
                        "Value : ",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(
                        child: TextFormField(
                          style: txtStyle(),
                          focusNode: valFocus,
                          onEditingComplete: () {
                            if (formkey.currentState.validate()) {
                              setState(() {
                                result = percentage(percent, value);
                              });
                            }
                          },
                          validator: (val) {
                            if (val.isNotEmpty) {
                              value = double.parse(val);
                              return null;
                            } else
                              return "Enter Value";
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Enter Value",
                              labelStyle: txtFormLabelStyle(),
                              hintText: "Eg. 120",
                              hintStyle: txtFormHintStyle(),
                              enabledBorder: txtFormLayoutStyle(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0))),
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
                        "Result : ",
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
                        FocusScope.of(context).requestFocus(perFocus);
                        setState(() {
                          result = 0.0;
                        });
                      },
                      text: "Reset",
                      gradientColors: myGradient,
                      width: myWidth, fontSize: myFontSize,
//                      style: resultTextStyle(),
                      padding: EdgeInsets.all(8.0),
                      background: Colors.blue,
                      elevation: myElevate,
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
                "$percent% of $value  = $result",
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
      result = percentage(percent, value);
    });
  }
}
