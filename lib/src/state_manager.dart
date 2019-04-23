import 'package:flib_lifecycle/flib_lifecycle.dart';

import 'core.dart';

class FStateManager {
  static final FStateManager singleton = FStateManager._();

  final Map<FState, _StateWrapper> _mapState = {};

  FStateManager._();

  void addState(FState state) {
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

  void _removeState(FState state) {
    final _StateWrapper wrapper = _mapState.remove(state);
    if (wrapper != null) {
      wrapper.dispose();
    }
  }

  List<T> getState<T extends FState>() {
    final List<T> result = [];
    final List<FState> list = _mapState.keys.toList(growable: false);
    list.forEach((item) {
      if (item.runtimeType == T) {
        result.add(item);
      }
    });
    return result;
  }
}

class _StateWrapper {
  final FState state;
  final FLifecycle lifecycle;

  _StateWrapper({
    this.state,
    this.lifecycle,
  }) : assert(lifecycle != null) {
    lifecycle.addObserver(_lifecycleObserver);
  }

  void _lifecycleObserver(FLifecycleEvent event, FLifecycle lifecycle) {
    if (event == FLifecycleEvent.onDestroy) {
      dispose();
      FStateManager.singleton._removeState(state);
    }
  }

  void dispose() {
    lifecycle.removeObserver(_lifecycleObserver);
  }
}
