import 'package:flib_lifecycle/flib_lifecycle.dart';
import 'package:flutter/material.dart';

class FStateLifecycleAdapter implements FLifecycleOwner, _StateLifecycle {
  final FLifecycleRegistry _lifecycleRegistry;
  bool _started;
  bool _startedMarker;

  FStateLifecycleAdapter({FLifecycleRegistry lifecycleRegistry})
      : this._lifecycleRegistry =
            lifecycleRegistry ?? SimpleLifecycleRegistry();

  @override
  FLifecycle getLifecycle() {
    return _lifecycleRegistry;
  }

  @override
  void initState() {
    _lifecycleRegistry.handleLifecycleEvent(FLifecycleEvent.onCreate);
  }

  @override
  Widget build(BuildContext context) {
    if (_startedMarker == null) {
      _startedMarker = true;
    }

    if (_startedMarker) {
      _startedMarker = false;
      _started = true;
      _lifecycleRegistry.handleLifecycleEvent(FLifecycleEvent.onStart);
    }

    return null;
  }

  @override
  void deactivate() {
    assert(_startedMarker == false);

    final bool expected = !_started;
    if (expected) {
      _startedMarker = true;
      // 等待build
    } else {
      _started = false;
      _lifecycleRegistry.handleLifecycleEvent(FLifecycleEvent.onStop);
    }
  }

  @override
  void dispose() {
    _started = null;
    _startedMarker = null;
    _lifecycleRegistry.handleLifecycleEvent(FLifecycleEvent.onDestroy);
  }
}

abstract class _StateLifecycle {
  void initState();

  Widget build(BuildContext context);

  void deactivate();

  void dispose();
}
