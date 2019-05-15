import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Edit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Location Edit'),
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
  String _location = '';

  Future<void> getLocation() async {
    
    LocationData locationData;
    var location = new Location();

    try {
      locationData = await location.getLocation();
      _location =locationData.altitude.toString();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        _location  = 'Permission denied';
      } else {
        _location = 'unknown Exception';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _location,
            ),
          ],
        ),
      ),
    );
  }
}
