import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:share/share.dart';

class PercentageChange extends StatefulWidget {
  @override
  _PercentageChangeState createState() => _PercentageChangeState();
}

class _PercentageChangeState extends State<PercentageChange> {
  final formkey = GlobalKey<FormState>();
  final fromValFocus = FocusNode();
  final toValFocus = FocusNode();
  double fromVal, toVal, result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Percentage Change",
          style: listTextStyle(),
        ),
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
                        "Initial Value : ",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: TextFormField(
                        focusNode: fromValFocus,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(toValFocus);
                        },
                        validator: (val) {
                          if (val.isEmpty)
                            return "Enter Initial Value";
                          else {
                            fromVal = double.parse(val);
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
                        "To Value :",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: TextFormField(
                        focusNode: toValFocus,
                        onEditingComplete: () {
                          if (formkey.currentState.validate()) calculate();
                        },
                        validator: (val) {
                          if (val.isEmpty)
                            return "Enter To Value";
                          else {
                            toVal = double.parse(val);
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
                      flex: 6,
                      child: Text(
                        "Percentage Change  :   ",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        alignment: Alignment.centerLeft,
                        height: conHeight,
                        decoration: resultWidget(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              result == null ? "0.0" : result.toString(),
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
                      gradientColors: myGradient,
                      width: myWidth,
//                      style: resultTextStyle(),
                      padding: EdgeInsets.all(8.0),
                      background: Colors.blue,
                      elevation: myElevate,
                      radius: myRadius, fontSize: myFontSize,
                      onPressed: () {
                        if (formkey.currentState.validate()) calculate();
                      },
                      text: "Calculate",
                    ),
                    NiceButton(
                      onPressed: () {
                        formkey.currentState.reset();
                        FocusScope.of(context).requestFocus(fromValFocus);
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
                "Initial Value  = $fromVal\n"
                "Final Value = $toVal\n"
                "Percentage Change = $result%",
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
      result = perChange(fromVal, toVal);
    });
  }
}
