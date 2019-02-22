import 'package:flutter/material.dart';

import './text_output.dart';

class TextControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextControlState();
  }
}

class _TextControlState extends State<TextControl> {
  String _mainText = 'Hello World!';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextOutput(_mainText),
        RaisedButton(
          onPressed: () {
            setState(() {
              _mainText = 'Hello Daniel!';
            });
          },
          child: Text('Hello ...'),
        )
      ],
    );
  }
}
