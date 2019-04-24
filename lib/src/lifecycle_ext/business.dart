import 'package:flib_core/src/core.dart';
import 'package:flib_lifecycle/flib_lifecycle.dart';
import 'package:flutter/material.dart';

abstract class FBusiness {
  FBusiness(FLifecycleOwner lifecycleOwner) {
    if (lifecycleOwner != null) {
      final FLifecycle lifecycle = lifecycleOwner.getLifecycle();
      assert(lifecycle != null);
      if (lifecycle.getCurrentState() == FLifecycleState.destroyed) {
        throw Exception('lifecycle is destroyed');
      }

      lifecycle.addObserver((event, lifecycle) {
        onLifecycleEvent(event);
      });
    }
  }

  void onLifecycleEvent(FLifecycleEvent event) {}

  void onDestroy() {}
}

abstract class FBusinessState<T extends StatefulWidget, B extends FBusiness>
    extends FState<T> {
  B get business;

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    if (B == FBusiness) {
      throw Exception('Generics "B" are not specified');
    }
  }
}
