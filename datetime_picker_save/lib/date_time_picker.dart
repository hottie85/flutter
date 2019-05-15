import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
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
            new _DatePicker(),
            new Text(' '),
            new TimePicker(),
            new Text(' Uhr')
          ],
        ),
      ],
    );
  }
}

class _DatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePicker> {
  DateTime _date = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: new Text(new DateFormat('dd.MM.yyyy').format(_date)),
        onTap: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            locale: 'de',
            minYear: 2000,
            maxYear: 3000,
            minDateTime: DateTime(2000),
            maxDateTime: DateTime(3000),
            initialDateTime: _date,
            cancel: Text('Abbrechen'),
            confirm: Text('OK'),
            dateFormat: 'dd-mm-yyyy',
            onChanged2: (dateTime, List<int> indexList) {},
            onConfirm2: (dateTime, List<int> indexList) {
              setState(() {
                _date = dateTime;
              });
            },
            onCancel: () {},
          );
        });
  }
}
