import 'package:flib_core/src/lifecycle_ext/state_lifecycle_adapter.dart';
import 'package:flib_core/src/state_manager.dart';
import 'package:flib_lifecycle/flib_lifecycle.dart';
import 'package:flutter/material.dart';

abstract class FApplication {
  bool _initialized = false;
  BuildContext context;

  bool get initialized => _initialized;

  Future<bool> initialize() async {
    final bool result = await initializeImpl();
    _initialized = true;
    return result;
  }

  @protected
  Future<bool> initializeImpl();

  void clearRoute(BuildContext context) {
    if (context == null) {
      return;
    }
    final NavigatorState navigator = Navigator.of(context);
    while (navigator.canPop()) {
      navigator.pop();
    }
  }
}

abstract class FState<T extends StatefulWidget> extends State<T>
    implements FLifecycleOwner {
  final FStateLifecycleAdapter _stateLifecycleAdapter =
      FStateLifecycleAdapter();

  /// 查找某个State
  S getState<S extends State>() {
    if (S == State) {
      throw Exception('Generics "S" are not specified');
    }
    return context == null
        ? null
        : context.ancestorStateOfType(TypeMatcher<S>());
  }

  @override
  FLifecycle getLifecycle() {
    return _stateLifecycleAdapter.getLifecycle();
  }

  /// 刷新当前ui
  void reBuild() {
    setState(() {});
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
    _stateLifecycleAdapter.initState();
  }

  @protected
  @mustCallSuper
  @override
  void deactivate() {
    super.deactivate();
    _stateLifecycleAdapter.deactivate();
  }

  @protected
  @mustCallSuper
  @override
  void dispose() {
    _stateLifecycleAdapter.dispose();
    super.dispose();
  }

  @protected
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    _stateLifecycleAdapter.build(context);
    return buildImpl(context);
  }

  @protected
  Widget buildImpl(BuildContext context);
}

abstract class FTargetState<T extends StatefulWidget, S extends State>
    extends FState<T> {
  S _targetState;

  S get targetState => _targetState;

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    if (S == State) {
      throw Exception('Generics "S" are not specified');
    }
  }

  @protected
  @mustCallSuper
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final S state = getState<S>();
    if (state != null) {
      if (_targetState != state) {
        _targetState = state;
        onTargetState(state);
      }
    }
  }

  /// 获取到目标State后回调此方法
  @protected
  void onTargetState(S state);
}

abstract class FViewModel {
  FViewModel(FLifecycleOwner lifecycleOwner) {
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
  /// 1. 如果构造方法的[FLifecycleOwner] == null，则此方法在构造方法里面触发
  /// 2. 如果构造方法的[FLifecycleOwner] != null，则此方法在[FLifecycleEvent.onCreate]生命周期触发
  void onCreate();

  /// 销毁
  void onDestroy() {}
}

abstract class FViewModelState<T extends StatefulWidget, VM extends FViewModel>
    extends FState<T> {
  VM _viewModel;

  /// 返回ViewModel对象
  VM get viewModel {
    if (_viewModel == null) {
      _viewModel = createViewModel();
      assert(_viewModel != null);
    }
    return _viewModel;
  }

  /// 返回一个ViewModel对象
  VM createViewModel();

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    if (VM == FViewModel) {
      throw Exception('Generics "VM" are not specified');
    }
  }
}

abstract class FRouteState<T extends StatefulWidget, VM extends FViewModel>
    extends FViewModelState<T, VM> {
  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    FStateManager.singleton.addState(this);
  }
}
