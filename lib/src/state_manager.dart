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
      wrapper.destroy();
    }
  }

  List<T> getState<T extends FState>() {
    final List<T> result = [];
    final List<FState> list = _mapState.keys.toList(growable: false);
    list.forEach((item) {
      if (item is T) {
        result.add(item);
      }
    });
    return result;
  }

  FState getLastState() {
    if (_mapState.isEmpty) {
      return null;
    }

    final List<FState> list = _mapState.keys.toList(growable: false);
    return list[list.length - 1];
  }
}

class _StateWrapper extends FLifecycleWrapper {
  final FState state;

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
