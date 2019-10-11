import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';

class DurationHourButton extends DurationButton {
  DurationHourButton(
      int value, DurationCallback onDurationCallback, bool selected)
      : super(
            value: value,
            unit: ' h',
            onDurationCallback: onDurationCallback,
            selected: selected);
}

class DurationMinuteButton extends DurationButton {
  DurationMinuteButton(
      int value, DurationCallback onDurationCallback, bool selected)
      : super(
            value: value,
            unit: "'",
            onDurationCallback: onDurationCallback,
            selected: selected);
}

class DurationOtherButton extends DurationButton {
  DurationOtherButton(DurationCallback onDurationCallback)
      : super(unit: '?', onDurationCallback: onDurationCallback);
}

class DurationButton extends StatefulWidget {
  final int value;
  final String unit;
  final DurationCallback onDurationCallback;
  final bool selected;

  DurationButton(
      {Key key, this.value, this.unit, this.onDurationCallback, this.selected})
      : super(key: key);

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

  void _buttonPressed(int duration) {
    widget.onDurationCallback(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return SelectableCircle(
      width: 70,
      child: Text(caption()),
      isSelected: widget.selected,
      onTap: () {
        _buttonPressed(widget.value);
      },
    );
  }
}

typedef void DurationCallback(int duration);
