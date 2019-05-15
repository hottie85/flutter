import 'package:flutter/material.dart';
import 'package:duration_edit/duration_buttons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dauer Edit',
      home: MyHomePage(title: 'Dauer Edit'),
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
        ),
        accentColor: Colors.white,
        buttonColor: Color.fromRGBO(28, 50, 128, 1.0),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey),
        ),
      ),
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
  @override
  Widget build(BuildContext context) {
    DateTime _now = DateTime.now();
    return Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new DurationButtons(
            date: DateTime(
                _now.year, _now.month, _now.day, _now.hour, _now.minute)),
      ),
    );
  }
}
