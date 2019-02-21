import 'package:flutter/material.dart';
import './date_picker.dart';
import './time_picker.dart';

class DateTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text('Datum & Zeit:'),
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new DatePicker(),
            new Text(' '),
            new TimePicker(),
            new Text(' Uhr')
          ],
        ),
      ],
    );
  }
}
