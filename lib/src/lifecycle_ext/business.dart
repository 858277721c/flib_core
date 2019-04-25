import 'package:flib_lifecycle/flib_lifecycle.dart';

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
