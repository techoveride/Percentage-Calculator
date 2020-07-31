import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:percentage_calculator/util/core_methods.dart';
import 'package:share/share.dart';

class TipCalculate extends StatefulWidget {
  @override
  _TipCalculateState createState() => _TipCalculateState();
}

class _TipCalculateState extends State<TipCalculate> {
  final formkey = GlobalKey<FormState>();
  final valFocus = FocusNode();
  final perFocus = FocusNode();
  final numFocus = FocusNode();
  double tipAmount, totalToPay, totalPerPersons, value, percent, numOfPeople;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calculate Tip",
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
                        "Total Amount : ",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: TextFormField(
                        focusNode: valFocus,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(numFocus);
                        },
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
                        "Number of People :",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: TextFormField(
                        focusNode: numFocus,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(perFocus);
                        },
                        validator: (val) {
                          if (val.isEmpty)
                            return "Enter Number of People";
                          else {
                            numOfPeople = double.parse(val);
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: txtStyle(),
                        decoration: InputDecoration(
                          labelText: "Enter value",
                          hintText: "Eg. 5",
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
                        "Tip Percentage : ",
                        style: listTextStyle(),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: TextFormField(
                        focusNode: perFocus,
                        onEditingComplete: () {
                          if (formkey.currentState.validate()) {
                            calculate();
                          }
                        },
                        validator: (val) {
                          if (val.isEmpty)
                            return "Enter Tip Percent";
                          else {
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Tip Amounts : ",
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
                            tipAmount == null ? "0.0" : tipAmount.toString(),
                            style: resultTextStyle(),
                          ),
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
                      flex: 5,
                      child: Text(
                        "Total to pay : ",
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
                            totalToPay == null ? "0.0" : totalToPay.toString(),
                            style: resultTextStyle(),
                          ),
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
                      flex: 5,
                      child: Text(
                        "Total per persons : ",
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
                            totalPerPersons == null
                                ? "0.0"
                                : totalPerPersons.toString(),
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
                      radius: myRadius, fontSize: myFontSize,
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
                          tipAmount = 0.0;
                          totalToPay = 0.0;
                          totalPerPersons = 0.0;
                        });
                      },
                      text: "Reset",
                      gradientColors: myGradient,
                      width: myWidth,
                      fontSize: myFontSize,
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
              calculate();
              String people = numOfPeople.toStringAsFixed(0);
              Share.share(
                "$percent% Tip of $value for $people people"
                " results to ;\n"
                "Tip Amount = $tipAmount\n"
                "Total to pay = $totalToPay\n"
                "Total per persons = $totalPerPersons",
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
      tipAmount = perTip(percent, value, numOfPeople).remove("Tip Amount");
      totalToPay = perTip(percent, value, numOfPeople).remove("Total to Pay");
      totalPerPersons =
          perTip(percent, value, numOfPeople).remove("Total Per Persons");
    });
  }
}
