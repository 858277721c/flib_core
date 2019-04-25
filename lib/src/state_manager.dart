import 'package:flib_lifecycle/flib_lifecycle.dart';

import 'core.dart';

class FStateManager {
  static final FStateManager singleton = FStateManager._();

  final Map<FRouteState, _StateWrapper> _mapState = {};

  FStateManager._();

  void addState(FRouteState state) {
    assert(state != null);
    if (!state.mounted) {
      return;
    }
    if (_mapState.containsKey(state)) {
      return;
    }
    final FLifecycle lifecycle = state.getLifecycle();
    assert(lifecycle != null);
    if (lifecycle.getCurrentState() == FLifecycleState.destroyed) {
      return;
    }

    final _StateWrapper wrapper = _StateWrapper(
      state: state,
      lifecycle: lifecycle,
    );

    _mapState[state] = wrapper;
  }

  void _removeState(FRouteState state) {
    final _StateWrapper wrapper = _mapState.remove(state);
    if (wrapper != null) {
      wrapper.destroy();
    }
  }

  List<T> getState<T extends FRouteState>() {
    final List<T> result = [];
    final List<FRouteState> list = _mapState.keys.toList(growable: false);
    list.forEach((item) {
      if (item is T) {
        result.add(item);
      }
    });
    return result;
  }

  FRouteState getLastState() {
    if (_mapState.isEmpty) {
      return null;
    }

    final List<FRouteState> list = _mapState.keys.toList(growable: false);
    return list[list.length - 1];
  }
}

class _StateWrapper extends FLifecycleWrapper {
  final FRouteState state;

  _StateWrapper({
    this.state,
    FLifecycle lifecycle,
  })  : assert(lifecycle != null),
        super(lifecycle);

  @override
  void onDestroy() {
    FStateManager.singleton._removeState(state);
  }
}
