import 'package:flutter/material.dart';

class LocationEdit extends StatefulWidget {
  final LocationSubmitted _onLocationSubmitted;

  LocationEdit(this._onLocationSubmitted);

  @override
  State<StatefulWidget> createState() =>
      LocationEditState(_onLocationSubmitted);
}

class LocationEditState extends State<LocationEdit> {
  TextEditingController textController = TextEditingController();

  LocationSubmitted _onLocationSubmitted;

  LocationEditState(this._onLocationSubmitted);

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
              onSubmitted: (text) {
                _onLocationSubmitted(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}

typedef void LocationSubmitted(String location);
