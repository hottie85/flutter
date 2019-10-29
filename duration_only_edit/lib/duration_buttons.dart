import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'duration_button.dart';
import 'flutter_duration_picker.dart';

/// shows 8 circles to chose a duration
///
/// between 0:15 and 4:45, there are fast buttons for every 15 min step
/// if you need an other duration you can choose from the ? circle
class DurationButtons extends StatefulWidget {
  /// initial time of the duration.
  ///  only the time portion of this DateTime is relevant.
  final DateTime initialDate;

  /// this is called, when the duration has changed
  final Function(int minutes) onTap;

  /// creates the widget
  DurationButtons({Key key, @required this.initialDate, this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DurationButtonsState(initialDate: initialDate);
  }
}

class _DurationButtonsState extends State<DurationButtons> {
  final DateTime initialDate;
  int _durationHour = 0;
  int _durationMinute = 0;

  _DurationButtonsState({@required this.initialDate}) : super();

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
  void initState() {
    super.initState();
    _durationHour = initialDate == null ? 2 : initialDate.hour;
    _durationMinute = initialDate == null ? 0 : initialDate.minute;
  }

  _durationHourPressed(int duration) {
    final hour = (_durationHour == duration)
        ? _durationHour = 0
        : _durationHour = duration;
    setHourAndMinute(hour, _durationMinute);
  }

  _durationMinutePressed(int duration) {
    final minute = (_durationMinute == duration)
        ? _durationMinute = 0
        : _durationMinute = duration;
    setHourAndMinute(_durationHour, minute);
  }

  _durationOtherPressed(int duration) async {
    final resultingDuration = await showDurationPicker(
      snapToMins: 5,
      context: context,
      initialTime: Duration(minutes: _durationMinute, hours: _durationHour),
    );
    if (resultingDuration != null) {
      setHourAndMinute(
          resultingDuration.inHours, resultingDuration.inMinutes % 60);
    }
  }

  String _getDurationText() {
    var result = '';
    result = Intl.plural(_durationHour,
        zero: '',
        one: '$_durationHour Stunde',
        other: '$_durationHour Stunden');

    result += Intl.plural(_durationMinute,
        zero: '',
        one: ' $_durationMinute Minute',
        other: ' $_durationMinute Minuten');
    return result;
  }

  void doOnTap() {
    if (widget.onTap == null) {
      return;
    }

    widget.onTap(_durationHour * 60 + _durationMinute);
  }

  void setHourAndMinute(int hour, int minute) {
    setState(() {
      _durationHour = hour;
      _durationMinute = minute;
    });
    doOnTap();
  }
}
