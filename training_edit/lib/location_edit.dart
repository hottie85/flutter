import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';

class LocationEdit extends StatefulWidget {
  final LocationSubmitted _onLocationSubmitted;
  final String _location;

  LocationEdit(this._location, this._onLocationSubmitted);

  @override
  State<StatefulWidget> createState() =>
      LocationEditState(_location, _onLocationSubmitted);
}

class LocationEditState extends State<LocationEdit> {
  TextEditingController textController = TextEditingController();

  LocationSubmitted _onLocationSubmitted;
  String _location;

  LocationEditState(this._location, this._onLocationSubmitted);

  @override
  void initState() {
    getLocation(_location).then((onValue) {
      textController.text = onValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Ort'),
        new Flexible(
          child: TextField(
            controller: textController,
            textAlign: TextAlign.right,
            decoration: new InputDecoration.collapsed(
              hintText: 'Ort eingeben',
            ),
            onSubmitted: (text) {
              _onLocationSubmitted(text);
            },
          ),
        ),
      ],
    );
  }

  Future<String> getLocation(String text) async {
    if (text != '') return text;
    LocationData currentLocation;

    var location = new Location();
    try {
      currentLocation = await location.getLocation();

      final coordinates =
          new Coordinates(currentLocation.latitude, currentLocation.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      return addresses.first.locality;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {}
      return '';
    }
  }
}

typedef void LocationSubmitted(String location);
