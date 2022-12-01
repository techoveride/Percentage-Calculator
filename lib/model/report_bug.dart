import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:nice_button/nice_button.dart';
import 'package:percentage_calculator/util/core_methods.dart';

class ReportBug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _reportController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Bug"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.report),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue, Colors.black38],
                transform: GradientRotation(8.0))),
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You can always report to us any crashes or bugs you might have come accross through the usage of our app.\n\nWe would be glad to hear from you improvements also as your ideas are priceless.\n\nUse the for below to forward your reports, Thank You!",
                  style: Theme.of(context).textTheme.headline5,
                  softWrap: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _reportController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "Report bug",
                      hintText:
                          "eg : App crashes when put in landscape mode on version 5.0 android",
                      enabled: true,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NiceButton(
                  text: "Send Now!",
                  elevation: 6.0,
                  onPressed: () {
                    var report = _reportController.text;
                    sendReport(report);
                  },
                  gradientColors: myDiagGradient,
                  background: Colors.transparent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendReport(report) async {
    if (report == null) report = '';
    final Email email = Email(
      body: 'Hi Techoveride !\n\n${report.toString()}'.trim(),
      subject: 'Percentage Calculator\nReport Bug/Crash',
      recipients: ['techoveride@outlook.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
