import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return new TextField(
      onChanged: (_text) {
        showDialog(context: context);
      },
      textAlign: TextAlign.center,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: 'Datum eingeben'),
      onTap: () {},
    );
  }
}
