import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Textfield that initializes with the location if possible
///
/// It does not check Location if a InitialValue is given
class LocationName extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  LocationName(this.initialValue, this.onChanged) {
    if (initialValue.isEmpty) {
      _getCurrentLocation();
    } else {
      _textController.text = initialValue;
    }
  }

  final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: onChanged,
    );
  }

  _getCurrentLocation() {
    _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((pos) {
      _getAddressFromLatLng(pos);
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(Position pos) async {
    try {
      final p = await _geolocator.placemarkFromCoordinates(
          pos.latitude, pos.longitude);
      _textController.text = p[0].locality;
    } catch (e) {
      print(e);
    }
  }
}
