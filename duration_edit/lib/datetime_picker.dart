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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(DateFormat('dd.MM.yyyy HH:mm').format(widget.initialDate)),
      onLongPress: () async {
        DateTime _selectedDate = await showDatePicker(
          context: context,
          firstDate: widget.firstDate,
          initialDate: widget.initialDate,
          lastDate: widget.lastDate,
          initialDatePickerMode: DatePickerMode.day,
        );
        if (_selectedDate != null) {
          widget.onDateTimeChanged(DateTime(
              _selectedDate.year,
              _selectedDate.month,
              _selectedDate.day,
              widget.initialDate.hour,
              widget.initialDate.minute));
        }
      },
      onTap: () async {
        TimeOfDay _selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(
                hour: widget.initialDate.hour,
                minute: widget.initialDate.minute));
        if (_selectedTime != null) {
          widget.onDateTimeChanged(DateTime(
              widget.initialDate.year,
              widget.initialDate.month,
              widget.initialDate.day,
              _selectedTime.hour,
              _selectedTime.minute));
        }
      },
    );
  }
}
