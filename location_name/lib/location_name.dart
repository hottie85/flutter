import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Textfield that initializes with the location if possible
///
/// It does not check Location if a InitialValue is given
class LocationName extends StatelessWidget {
  /// value that should be shown
  /// if this value is set the location will not be checked
  final String initialValue;

  /// onChanged of the Textfield
  final ValueChanged<String> onChanged;

  /// creates the widget
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
        .then(_getAddressFromLatLng)
        .catchError(print);
  }

  _getAddressFromLatLng(Position pos) async {
    try {
      final p = await _geolocator.placemarkFromCoordinates(
          pos.latitude, pos.longitude);
      _textController.text = p[0].locality;
    } on Exception catch (e) {
      print(e);
    }
  }
}
