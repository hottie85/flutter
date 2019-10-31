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

  /// decoration of the Textfield
  final InputDecoration decoration;

  /// this is displayed while loading the location
  ///
  /// default a CircularProgressIndicator is shown
  final Widget loadingIndicator;

  /// creates the widget
  LocationName({
    this.initialValue,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.loadingIndicator = const CircularProgressIndicator(),
  }) {
    if (initialValue != null && initialValue.isNotEmpty) {
      _textController.text = initialValue;
    }
  }

  final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_textController.text.isNotEmpty) return _buildTextField();
    return FutureBuilder<String>(
      future: _getLocality(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _textController.text = snapshot.data;
          return _buildTextField();
        } else if (snapshot.hasError) {
          return _buildTextField();
        }
        // By default, show a loading spinner
        return loadingIndicator;
      },
    );
  }

  Future<String> _getLocality() async {
    final pos = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final p = await _geolocator.placemarkFromPosition(pos);
    return p[0].locality;
  }

  Widget _buildTextField() {
    return TextField(
      controller: _textController,
      onChanged: onChanged,
      decoration: decoration,
    );
  }
}
