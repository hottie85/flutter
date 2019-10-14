import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationNameState();
}

class _LocationNameState extends State<LocationName> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    if ((_currentPosition != null) && (_currentAddress != null))
      return Text(_currentAddress);
    else
      return Text('');
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
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
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = place.locality;
      });
    } catch (e) {
      print(e);
    }
  }
}
