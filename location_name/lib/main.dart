import 'package:flutter/material.dart';
import 'location_name.dart';
import 'location_name_stream.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Name',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'Loacation Name'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LocationNameStream(
              initialValue: "HS 23",
              onChanged: (x) => print("stream: $x"),
            ),
            LocationName(
              onChanged: print,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: "Ort"),
            ),
          ],
        ),
      ),
    );
  }
}
