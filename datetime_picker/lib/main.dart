import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:datetime_picker/datetime_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('en', 'EN'),
        const Locale('de', 'DE'),
        // ...
      ],
      title: 'DateTime_Picker',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'DateTime_Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: DateTimePicker(
          firstDate: DateTime(_dateTime.year, _dateTime.month, _dateTime.day),
          initialDate: DateTime.now(),
          lastDate: new DateTime(3000),
          onDateTimeChanged: (DateTime value) {
            print(value.toString());
          },
        ),
      ),
    );
  }
}
