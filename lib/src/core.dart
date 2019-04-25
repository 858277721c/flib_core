import 'package:flib_core/src/lifecycle_ext/business.dart';
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
    super.dispose();
    _stateLifecycleAdapter.dispose();
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

  @protected
  void onTargetState(S state);
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

abstract class FRouteState<T extends StatefulWidget, B extends FBusiness>
    extends FBusinessState<T, B> {
  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    FStateManager.singleton.addState(this);
  }
}
