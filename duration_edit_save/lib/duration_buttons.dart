import 'package:flutter/material.dart';
import 'package:duration_edit/duration_button.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:duration_edit/datetime_picker.dart';

class DurationButtons extends StatefulWidget {
  final DateTime date;

  DurationButtons({Key key, @required this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _DurationButtonsState(date: date);
  }
}

class _DurationButtonsState extends State<DurationButtons> {
  final DateTime date;
  DateTime _startDate;
  DateTime _endDate;
  int _durationHour = 0;
  int _durationMinute = 0;

  _DurationButtonsState({@required this.date}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Datum & Zeit Beginn'),
            DateTimePicker(
              initialDate: _startDate,
              firstDate: DateTime(2000, 1, 1),
              lastDate: DateTime(3000, 1, 1),
              onDateTimeChanged: (dateTime) {
                setState(() {
                  _startDate = dateTime;
                  _setEndDate();
                });
              },
            )
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text('Dauer gesamt/'), Text(_getDurationText())],
        ),
        Container(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Ende'),
            DateTimePicker(
              initialDate: _endDate,
              firstDate: DateTime(2000, 1, 1),
              lastDate: DateTime(3000, 1, 1),
              onDateTimeChanged: (dateTime) {
                setState(() {
                  if (dateTime.compareTo(_startDate) < 0) _startDate = dateTime;
                  _endDate = dateTime;
                  _calcDuration();
                });
              },
            )
          ],
        ),
        Container(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            DurationHourButton(1, _durationHourPressed, _durationHour == 1),
            DurationHourButton(2, _durationHourPressed, _durationHour == 2),
            DurationHourButton(3, _durationHourPressed, _durationHour == 3),
            DurationHourButton(4, _durationHourPressed, _durationHour == 4),
          ],
        ),
        Container(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            DurationMinuteButton(
                15, _durationMinutePressed, _durationMinute == 15),
            DurationMinuteButton(
                30, _durationMinutePressed, _durationMinute == 30),
            DurationMinuteButton(
                45, _durationMinutePressed, _durationMinute == 45),
            DurationOtherButton(_durationOtherPressed),
          ],
        ),
      ],
    );
  }

  @override
  initState() {
    super.initState();
    _startDate = this.date;
    _endDate = this.date.add(Duration(hours: 2));
    _durationHour = 2;
    _durationMinute = 0;
  }

  _durationHourPressed(int duration) {
    setState(() {
      (_durationHour == duration)
          ? _durationHour = 0
          : _durationHour = duration;
      _setEndDate();
    });
  }

  _durationMinutePressed(int duration) {
    setState(() {
      (_durationMinute == duration)
          ? _durationMinute = 0
          : _durationMinute = duration;
      _setEndDate();
    });
  }

  _setEndDate() {
    _endDate = _startDate
        .add(new Duration(hours: _durationHour, minutes: _durationMinute));
  }

  _durationOtherPressed(int duration) async {
    Duration resultingDuration = await showDurationPicker(
      snapToMins: 5,
      context: context,
      initialTime: new Duration(minutes: _durationMinute, hours: _durationHour),
    );
    if (resultingDuration != null) {
      setState(() {
        _durationHour = resultingDuration.inHours;
        _durationMinute = resultingDuration.inMinutes;

        if (_durationHour > 0)
          _durationMinute = _durationMinute % (_durationHour * 60);
        _endDate = _startDate.add(resultingDuration);
      });
    }
  }

  _calcDuration() {
    DateTime _start = DateTime(_startDate.year, _startDate.month,
        _startDate.day, _startDate.hour, _startDate.minute);
    DateTime _end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endDate.hour, _endDate.minute);

    _durationHour = _end.difference(_start).inHours;
    _durationMinute = _end.difference(_start).inMinutes;
    if (_durationHour > 0)
      _durationMinute = _durationMinute % (_durationHour * 60);
  }

  String _getDurationText() {
    String result = '';
    if (_durationHour > 0) {
      result = _durationHour.toString() + ' Stunde';
      if (_durationHour > 1) result = result + 'n';
    }
    if (_durationMinute > 0) {
      if (result != '') result = result + ' ';
      result = result + _durationMinute.toString() + ' Minute';
      if (_durationMinute > 1) result = result + 'n';
    }
    return result;
  }
}
