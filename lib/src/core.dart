import 'package:flutter/material.dart';

abstract class FState<T extends StatefulWidget> extends State<T> {
  bool _paused = false;

  @mustCallSuper
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    _paused = !_paused;

    if (_paused) {
      onPause();
    } else {
      onResume();
    }
  }

  void onPause() {}

  void onResume() {}
}
