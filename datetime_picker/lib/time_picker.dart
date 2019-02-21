import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TimePickerState();
  }
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay _picked = await showTimePicker(
        context: context,
        initialTime: _time,
    );

    if ((_picked != null) && (_picked != _time)) {
      setState(() {
        _time = _picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {_selectTime(context);},
      child: new Text(new DateFormat('HH:mm').format(new DateTime(2000, 1, 1, _time.hour, _time.minute))),

    );
  }
}
