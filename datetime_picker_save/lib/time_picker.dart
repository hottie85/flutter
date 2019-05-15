import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TimePickerState();
  }
}

class _TimePickerState extends State<TimePicker> {
  DateTime _time = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    DatePicker.showTimePicker(context, 
    
    onConfirm: (time) {
      setState(() {
       _time = time; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        _selectTime(context);
      },
      child: new Text(new DateFormat('HH:mm')
          .format(new DateTime(2000, 1, 1, _time.hour, _time.minute))),
    );
  }
}
