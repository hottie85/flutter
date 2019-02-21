import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'date_time_picker.dart';

void main() {
  runApp(new MaterialApp(
    home: new NewMyApp(),
  ));
}

class NewMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
       localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
          const Locale('en', 'US'),
          const Locale('de', 'DE'),
      ],
      home:  Scaffold(
      appBar: new AppBar(
        title: new Text('DateTimePicker'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new DateTimePicker(),
        ),
      ));
  }
}