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
        if (event == FLifecycleEvent.onDestroy) {
          onDestroy();
        }
      });
    }
  }

  void onDestroy() {}
}
