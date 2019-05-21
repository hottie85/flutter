import 'package:flutter/material.dart';

class LocationEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationEditState();
}

class LocationEditState extends State<LocationEdit> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Ort'),
          new Flexible(
            child: TextField(
              controller: textController,
              textAlign: TextAlign.right,
              decoration: new InputDecoration.collapsed(
                hintText: 'Ort eingeben',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
