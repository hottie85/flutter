import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Textfield that initializes with the location if possible
class LocationName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationNameState();
}

class _LocationNameState extends State<LocationName> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    if ((_currentPosition != null) && (_currentAddress != null)) {
      _textController.text = _currentAddress;
    } else {
      _textController.text = '';
    }
    return TextField(controller: _textController);
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      var p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      var place = p[0];

      setState(() {
        _currentAddress = place.locality;
      });
    } catch (e) {
      print(e);
    }
  }
}
