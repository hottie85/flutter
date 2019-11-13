import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

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
  /// by default a LinearProgressIndicator is shown
  final Widget loadingIndicator;
  final FocusNode _focusNode = FocusNode();

  /// creates the widget
  LocationName({
    this.initialValue,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.loadingIndicator,
  }) {
    if (initialValue != null && initialValue.isNotEmpty) {
      _textController.text = initialValue;
    }
  }

  final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;
  final _showCancelSubject = BehaviorSubject<bool>();
  Stream<bool> get _showCancelStream => _showCancelSubject.stream;
  final _showLoadingSubject = BehaviorSubject<bool>();
  Stream<bool> get _showLoadingStream => _showLoadingSubject.stream;

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_textController.text.isNotEmpty) {
      return _buildTextField(false);
    }
    return FutureBuilder<String>(
      future: _getLocality(),
      builder: (context, snapshot) {
        final wList = <Widget>[];
        wList.add(_buildTextField(!snapshot.hasData && !snapshot.hasError));
        wList.add(_buildLoadingIndicator());

        // By default, show a loading spinner
        if (snapshot.hasData && _textController.text.isEmpty) {
          _textController.text = snapshot.data;
          _showLoadingSubject.add(false);
        }
        return Column(
          children: wList.toList(),
        );
      },
    );
  }

  StreamBuilder<bool> _buildLoadingIndicator() {
    return StreamBuilder(
      stream: _showLoadingStream,
      initialData: true,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          if (snapshot.data) {
            return loadingIndicator ??
                Container(height: 1, child: LinearProgressIndicator());
          }
        }
        return Container();
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
      onChanged: _onTextChanged,
      decoration: decoration,
      focusNode: _focusNode,
    ));

    wList.add(
      _buildCancel(loading),
    );
    return Stack(
      children: wList.toList(),
    );
  }

  StreamBuilder<bool> _buildCancel(bool loading) {
    return StreamBuilder(
      stream: _showCancelStream,
      initialData: loading || _textController.text.isNotEmpty,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  child: Icon(Icons.cancel), onTap: () => _onCancel(context)),
            ),
            // constraints: BoxConstraints.expand(),
          );
        }
        return Container();
      },
    );
  }

  _onTextChanged(String text) {
    _disableShowLoading();
    if (_showCancelSubject.value == null ||
        _showCancelSubject.value != _textController.text.isNotEmpty) {
      _showCancelSubject.add(_textController.text.isNotEmpty);
    }
    onChanged(text);
  }

  void _disableShowLoading() {
    if (_showLoadingSubject.value ?? true) {
      _showLoadingSubject.add(false);
    }
  }

  void _onCancel(BuildContext context) {
    _textController.text = '';
    _disableShowLoading();

    if (_showCancelSubject.value ?? true) {
      _showCancelSubject.add(false);
    }
    FocusScope.of(context).requestFocus(_focusNode);
  }
}
