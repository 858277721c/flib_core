import 'package:flutter/material.dart';

abstract class FState<T extends StatefulWidget> extends State<T> {
  bool _paused = false;

  /// 查找某个State
  static T get<T extends State>(BuildContext context) {
    return context.ancestorStateOfType(new TypeMatcher<T>());
  }

  @mustCallSuper
  @protected
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @mustCallSuper
  @protected
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

  @mustCallSuper
  @protected
  void onPause() {}

  @mustCallSuper
  @protected
  void onResume() {}
}
