import 'package:flutter/material.dart';
import 'package:duration_edit/duration_button.dart';

import 'flutter_duration_picker.dart';

class DurationButtons extends StatefulWidget {
  final DateTime date;

  DurationButtons({Key key, @required this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DurationButtonsState(date: date);
  }
}

class _DurationButtonsState extends State<DurationButtons> {
  final DateTime date;
  int _durationHour = 0;
  int _durationMinute = 0;

  _DurationButtonsState({@required this.date}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
        Container(
          height: 10.0,
        ),
        Text(_getDurationText()),
      ],
    );
  }

  @override
  initState() {
    super.initState();
    _durationHour = 2;
    _durationMinute = 0;
  }

  _durationHourPressed(int duration) {
    setState(() {
      (_durationHour == duration)
          ? _durationHour = 0
          : _durationHour = duration;
    });
  }

  _durationMinutePressed(int duration) {
    setState(() {
      (_durationMinute == duration)
          ? _durationMinute = 0
          : _durationMinute = duration;
    });
  }

  _durationOtherPressed(int duration) async {
    Duration resultingDuration = await showDurationPicker(
      snapToMins: 5,
      context: context,
      initialTime: Duration(minutes: _durationMinute, hours: _durationHour),
    );
    if (resultingDuration != null) {
      setState(() {
        _durationHour = resultingDuration.inHours;
        _durationMinute = resultingDuration.inMinutes;

        if (_durationHour > 0)
          _durationMinute = _durationMinute % (_durationHour * 60);
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
