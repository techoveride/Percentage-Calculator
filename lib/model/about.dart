import 'package:flutter/material.dart';
import 'package:percentage_calculator/util/core_methods.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 8.0,
          title: Text(
            "About",
            style: TextStyle(
                fontFamily: 'SansSerif',
                fontWeight: FontWeight.w800,
                fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: aboutBoxStyle(),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                "A simple calcultor for calculating percentages of varius kinds.",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "version : 1.0.0",
                  style: txtSuffixStyle(),
                ),
              ),
            ),
          ),
        ));
  }
}
