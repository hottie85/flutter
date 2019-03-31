import 'package:flutter/material.dart';
import 'package:duration_edit/duration_button.dart';

class DurationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Dauer'),
            Text('11:11')
          ],
        ),
        Container(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Ende'),
            Text('xxxx')
          ],),
        Container(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            DurationHourButton(0),
            DurationHourButton(1),
            DurationHourButton(2),
            DurationHourButton(3),
          ],
        ),
        Container(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            DurationMinuteButton(15),
            DurationMinuteButton(30),
            DurationMinuteButton(45),
            DurationOtherButton(),
          ],
        ),
      ],
    );
  }
}
