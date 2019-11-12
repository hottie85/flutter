import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

/// Textfield that initializes with the location if possible
///
/// It does not check Location if a InitialValue is given
class LocationNameStream extends StatefulWidget {
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

  /// creates the widget
  LocationNameStream({
    this.initialValue,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.loadingIndicator,
  });

  @override
  _LocationNameState createState() => _LocationNameState();
}

class _LocationNameState extends State<LocationNameStream> {
  final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;
  final _showCancelSubject = BehaviorSubject<bool>();
  Stream<bool> get _showCancelStream => _showCancelSubject.stream;
  final _showLoadingSubject = BehaviorSubject<bool>();
  Stream<bool> get _showLoadingStream => _showLoadingSubject.stream;

  final TextEditingController _textController = TextEditingController();

  bool _showLoading = true;
  bool _streamVal = true;
  bool _loading = true;

  @override
  void initState() {
    if (widget.initialValue != null && widget.initialValue.isNotEmpty) {
      _textController.text = widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_textController.text.isNotEmpty) {
      _loading = false;
      return _buildTextField();
    }
    return FutureBuilder<String>(
      future: _getLocality(),
      builder: (context, snapshot) {
        final wList = <Widget>[];
        wList.add(_buildTextField());
        _loading = !snapshot.hasData && !snapshot.hasError;
        wList.add(StreamBuilder(
          stream: _showLoadingStream,
          initialData: _showLoading,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              if (_loading && snapshot.data && _showLoading) {
                return widget.loadingIndicator ??
                    Container(height: 1, child: LinearProgressIndicator());
              }
            }
            return Container();
          },
        ));

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

  Widget _buildTextField() {
    final wList = <Widget>[];
    wList.add(TextField(
      controller: _textController,
      onChanged: onTextChanged,
      decoration: widget.decoration,
    ));

    wList.add(
      StreamBuilder(
        stream: _showCancelStream,
        initialData: _streamVal,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return Container(
              height: 40,
              child: Align(
                alignment: Alignment.centerRight,
                child:
                    GestureDetector(child: Icon(Icons.cancel), onTap: onCancel),
              ),
              // constraints: BoxConstraints.expand(),
            );
          }
          return Container();
        },
      ),
    );
    return Stack(
      children: wList.toList(),
    );
  }

  onTextChanged(String text) {
    _disableShowLoading();

    final shouldshowCancel =
        (_showLoading && _loading) || _textController.text.isNotEmpty;
    if (_streamVal != shouldshowCancel) {
      _streamVal = shouldshowCancel;
      _showCancelSubject.add(_streamVal);
    }
    widget.onChanged(text);
  }

  @override
  void dispose() {
    _showCancelSubject.close();
    super.dispose();
  }

  void _disableShowLoading() {
    if (_showLoading) {
      _showLoading = false;
      _showLoadingSubject.add(_showLoading);
    }
  }

  void onCancel() {
    if (!_showLoading) {
      _textController.text = '';
    }
    _disableShowLoading();
    _streamVal = (_showLoading && _loading) || _textController.text.isNotEmpty;
    _showCancelSubject.add(_streamVal);
  }
}
