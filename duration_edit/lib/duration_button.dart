import 'package:flutter/material.dart';

class DurationHourButton extends DurationButton {
  DurationHourButton(int value) : super(value: value, unit: ' h');
}

class DurationMinuteButton extends DurationButton {
  DurationMinuteButton(int value) : super(value: value, unit: "'");
}

class DurationOtherButton extends DurationButton {
  DurationOtherButton() : super(unit: '?');
}

class DurationButton extends StatefulWidget {
  final int value;
  final String unit;

  const DurationButton({Key key, this.value, this.unit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DurationButtonState();
}

class _DurationButtonState extends State<DurationButton> {
  String caption() {
    if (widget.value != null)
      return widget.value.toString() + widget.unit;
    else
      return widget.unit;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _durationPressed,
      tooltip: 'Increment',
      child: Text(caption()),
    );
  }

  void _durationPressed() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(widget.value.toString()),
          );
        });
  }
}
