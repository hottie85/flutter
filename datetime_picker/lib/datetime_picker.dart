import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime firstDate;
  final DateTime initialDate;
  final DateTime lastDate;

  DateTimePicker(
      {Key key,
      @required this.onDateTimeChanged,
      @required this.firstDate,
      @required this.initialDate,
      @required this.lastDate})
      : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime _dateTime;

  @override
  void initState() {
    _dateTime = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: Text(DateFormat('dd.MM.yyyy').format(_dateTime)),
          onTap: () async {
            DateTime _selectedDate = await showDatePicker(
              context: context,
              firstDate: widget.firstDate,
              initialDate: _dateTime,
              lastDate: widget.lastDate,
              initialDatePickerMode: DatePickerMode.day,
            );
            if (_selectedDate != null) {
              setState(() {
                _dateTime = DateTime(_selectedDate.year, _selectedDate.month,
                    _selectedDate.day, _dateTime.hour, _dateTime.minute);
              });
              widget.onDateTimeChanged(_dateTime);
            }
          },
        ),
        Text(' '),
        GestureDetector(
          child: Text(DateFormat('HH:mm').format(_dateTime)),
          onTap: () async {
            TimeOfDay _selectedTime = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute));
            if (_selectedTime != null) {
              setState(() {
                _dateTime = DateTime(_dateTime.year, _dateTime.month,
                    _dateTime.day, _selectedTime.hour, _selectedTime.minute);
              });
              widget.onDateTimeChanged(_dateTime);
            }
          },
        )
      ],
    );
  }
}
