import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Textfield that initializes with the location if possible
///
/// It does not check Location if a InitialValue is given
class LocationNameNoStream extends StatefulWidget {
  /// value that should be shown
  /// if this value is set the location will not be checked
  final String initialValue;

  /// onChanged of the Textfield
  final ValueChanged<String> onChanged;

  /// decoration of the Textfield
  final InputDecoration decoration;

  /// is called when the location loading is canceled
  final void Function() onCancel;

  /// this is displayed while loading the location
  ///
  /// by default a LinearProgressIndicator is shown
  final Widget loadingIndicator;

  /// creates the widget
  LocationNameNoStream({
    this.initialValue,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.loadingIndicator,
    this.onCancel,
  });

  @override
  _LocationNameState createState() => _LocationNameState();
}

class _LocationNameState extends State<LocationNameNoStream> {
  final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;

  final TextEditingController _textController = TextEditingController();

  bool _showLoading = true;

  @override
  void initState() {
    if (widget.initialValue != null && widget.initialValue.isNotEmpty) {
      _textController.text = widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_textController.text.isNotEmpty) return _buildTextField(false);
    return FutureBuilder<String>(
      future: _getLocality(),
      builder: (context, snapshot) {
        final wList = <Widget>[];
        final loading = !snapshot.hasData && !snapshot.hasError;
        wList.add(_buildTextField(loading));
        if (loading && _showLoading) {
          final load = widget.loadingIndicator ??
              Container(height: 1, child: LinearProgressIndicator());
          wList.add(load);
        }
        // By default, show a loading spinner
        if (snapshot.hasData && _showLoading) {
          _textController.text = snapshot.data;
        }
        return Column(
          children: wList.toList(),
        );
      },
    );
  }

  Future<String> _getLocality() async {
    final pos = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final p = await _geolocator.placemarkFromPosition(pos);
    return p[0].locality;
  }

  Widget _buildTextField(bool loading) {
    final wList = <Widget>[];
    wList.add(TextField(
      controller: _textController,
      onChanged: onTextChanged,
      decoration: widget.decoration,
    ));
    if ((_showLoading && loading) || _textController.text.isNotEmpty) {
      wList.add(
        Container(
          height: 40,
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                child: Icon(Icons.cancel),
                onTap: () {
                  setState(() {
                    if (loading) {
                      _showLoading = false;
                    } else {
                      _textController.text = "";
                    }
                  });
                }),
          ),
          // constraints: BoxConstraints.expand(),
        ),
      );
    }
    return Stack(
      children: wList.toList(),
    );
  }

  onTextChanged(String text) {
    setState(() {
      _showLoading = false;
    });
    widget.onChanged(text);
  }
}
