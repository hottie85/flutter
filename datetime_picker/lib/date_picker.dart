import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DatePickerState();
  }
}

class _DatePickerState extends State<DatePicker> {
  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2000),
        lastDate: new DateTime(3000),
        locale: const Locale('de'));

    if ((_picked != null) && (_picked != _date)) {
      setState(() {
        _date = _picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: new Text(new DateFormat('dd.MM.yyyy').format(_date)),
        onTap: () {
          _selectDate(context);
        });
  }
}
