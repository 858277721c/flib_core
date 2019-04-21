import 'package:flib_lifecycle/flib_lifecycle.dart';
import 'package:flutter/material.dart';

abstract class FApplication {
  bool _initialized = false;

  bool get initialized => _initialized;

  Future<bool> initialize() async {
    final bool result = await initializeImpl();
    _initialized = true;
    return result;
  }

  @protected
  Future<bool> initializeImpl();
}

abstract class FState<T extends StatefulWidget> extends State<T>
    implements FLifecycleOwner {
  final SimpleLifecycle _lifecycle = SimpleLifecycle();
  bool _started;

  bool get started => _started;

  /// 查找某个State
  T getState<T extends State>() {
    assert(T != State);
    if (context == null) {
      return null;
    }
    final State state = context.ancestorStateOfType(TypeMatcher<T>());
    return state == null ? null : state as T;
  }

  @override
  FLifecycle getLifecycle() {
    return _lifecycle;
  }

  @protected
  @mustCallSuper
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _lifecycle.handleLifecycleEvent(FLifecycleEvent.onCreate);
  }

  @protected
  @mustCallSuper
  @override
  void deactivate() {
    super.deactivate();
    _started = !_started;
    _notifyStartOrStop();
  }

  @protected
  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _lifecycle.handleLifecycleEvent(FLifecycleEvent.onDestroy);
  }

  @protected
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    if (_started == null) {
      _started = true;
      _notifyStartOrStop();
    }
    return buildImpl(context);
  }

  @protected
  Widget buildImpl(BuildContext context);

  void _notifyStartOrStop() {
    if (_started == null) {
      return;
    }

    if (_started) {
      onStart();
      _lifecycle.handleLifecycleEvent(FLifecycleEvent.onStart);
    } else {
      onStop();
      _lifecycle.handleLifecycleEvent(FLifecycleEvent.onStop);
    }
  }

  @protected
  @mustCallSuper
  void onStart() {}

  @protected
  @mustCallSuper
  void onStop() {}
}
