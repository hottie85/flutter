import 'package:flutter/material.dart';

class LocationEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationEditState();
}

class LocationEditState extends State<LocationEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text('Ort'), Text('Ort wählen ...')],
      ),
    );
  }
}
