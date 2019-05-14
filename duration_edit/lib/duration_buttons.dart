import 'package:flutter/material.dart';
import 'package:duration_edit/duration_button.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

import 'package:intl/intl.dart';

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

  DateTime _endDate = new DateTime.now();

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
            Text('Beginn'),
            Text(new DateFormat("dd.MM.yyyy HH:mm").format(date))
          ],
        ),
        Container(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text('Dauer'), Text(_getDurationText())],
        ),
        Container(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Ende'),
            Text(new DateFormat("dd.MM.yyyy HH:mm").format(_endDate))
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
            DurationMinuteButton(15, _durationMinutePressed, _durationMinute == 15),
            DurationMinuteButton(30, _durationMinutePressed, _durationMinute == 30),
            DurationMinuteButton(45, _durationMinutePressed, _durationMinute == 45),
            DurationOtherButton(_durationOtherPressed),
          ],
        ),
      ],
    );
  }

  @override
  initState() {
    super.initState();
    _endDate = this.date;
  }

  _durationHourPressed(int duration) {
    setState(() {
      if (_durationHour == duration)
        _durationHour = 0;
      else
        _durationHour = duration;

      _endDate = date
          .add(new Duration(hours: _durationHour, minutes: _durationMinute));
    });
  }

  _durationMinutePressed(int duration) {
    setState(() {
      if (_durationMinute == duration)
        _durationMinute = 0;
      else
        _durationMinute = duration;

      _endDate = date
          .add(new Duration(hours: _durationHour, minutes: _durationMinute));
    });
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
        _endDate = date.add(resultingDuration);
      });
    }
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
