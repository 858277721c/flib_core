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
        switch (event) {
          case FLifecycleEvent.onCreate:
            onCreate();
            break;
          case FLifecycleEvent.onStart:
            onStart();
            break;
          case FLifecycleEvent.onStop:
            onStop();
            break;
          case FLifecycleEvent.onDestroy:
            onDestroy();
            break;
        }
      });
    }
  }

  void onCreate();

  void onStart() {}

  void onStop() {}

  void onDestroy() {}
}

abstract class FBusinessState<T extends StatefulWidget, B extends FBusiness>
    extends FState<T> {
  B _business;

  B get business {
    if (_business == null) {
      _business = createBusiness();
      assert(_business != null);
    }
    return _business;
  }

  B createBusiness();

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
