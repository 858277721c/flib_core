import 'package:flutter/material.dart';

abstract class FState<T extends StatefulWidget> extends State<T> {
  bool _paused = false;

  /// 查找某个State
  T ancestorState<T extends State>() {
    assert(T != State);
    if (context == null) {
      return null;
    }
    final State state = context.ancestorStateOfType(TypeMatcher<T>());
    return state == null ? null : state as T;
  }

  @mustCallSuper
  @protected
  @override
  Widget build(BuildContext context) {
    return buildImpl(context);
  }

  Widget buildImpl(BuildContext context);

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
