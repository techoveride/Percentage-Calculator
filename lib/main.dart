import 'package:flutter/material.dart';
import 'package:percentage_calculator/util/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Percentage Calculator",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
//      theme: ThemeData.dark(),
    );
  }
}
