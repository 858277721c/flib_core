import 'package:flib_lifecycle/flib_lifecycle.dart';

abstract class FBusiness {
  FBusiness(FLifecycle lifecycle) {
    if (lifecycle != null) {
      if (lifecycle.getCurrentState() == FLifecycleState.destroyed) {
        throw Exception('lifecycle is destroyed');
      }

      lifecycle.addObserver((event, lifecycle) {
        switch (event) {
          case FLifecycleEvent.onCreate:
            onCreate();
            break;
          case FLifecycleEvent.onDestroy:
            onDestroy();
            break;
          default:
            break;
        }
      });
    } else {
      onCreate();
    }
  }

  /// 创建
  ///
  /// 1. 如果构造方法的[lifecycle] == null，则此方法在构造方法里面触发
  /// 2. 如果构造方法的[lifecycle] != null，则此方法在[FLifecycleEvent.onCreate]生命周期触发
  void onCreate();

  /// 销毁
  void onDestroy() {}
}
