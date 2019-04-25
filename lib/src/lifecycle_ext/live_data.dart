import 'package:flib_lifecycle/flib_lifecycle.dart';

/// 值变化观察者
typedef FLiveDataObserver<T> = void Function(T value);

class FLiveData<T> {
  final Map<FLiveDataObserver<T>, _ObserverWrapper<T>> _mapObserver = {};
  T _value;

  FLiveData(T value) : this._value = value;

  /// 返回保存的值
  T get value => _value;

  /// 设置值
  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _notifyObserver();
    }
  }

  void _notifyObserver() {
    if (_mapObserver.isEmpty) {
      return;
    }

    final List<_ObserverWrapper<T>> list =
        _mapObserver.values.toList(growable: false);

    list.forEach((item) {
      item.notifyValue(_value);
    });
  }

  /// 添加观察者
  void addObserver(
    FLiveDataObserver<T> observer,
    FLifecycleOwner lifecycleOwner, {
    bool notifyAfterAdded = true,
    bool notifyLazy = true,
  }) {
    if (_mapObserver.containsKey(observer)) {
      return;
    }

    FLifecycle lifecycle;
    if (lifecycleOwner != null) {
      lifecycle = lifecycleOwner.getLifecycle();
      assert(lifecycle != null);
    }

    assert(notifyLazy != null);
    final _ObserverWrapper<T> wrapper = notifyLazy
        ? _LazyObserverWrapper<T>(
            observer: observer,
            lifecycle: lifecycle,
            liveData: this,
          )
        : _ObserverWrapper<T>(
            observer: observer,
            lifecycle: lifecycle,
            liveData: this,
          );

    _mapObserver[observer] = wrapper;

    assert(notifyAfterAdded != null);
    if (notifyAfterAdded) {
      if (_value != null) {
        wrapper.notifyValue(_value);
      }
    }
  }

  /// 移除观察者
  void removeObserver(FLiveDataObserver<T> observer) {
    final _ObserverWrapper wrapper = _mapObserver.remove(observer);
    if (wrapper != null) {
      wrapper.destroy();
    }
  }
}

class _ObserverWrapper<T> extends FLifecycleWrapper {
  final FLiveDataObserver<T> observer;
  final FLiveData liveData;

  _ObserverWrapper({
    this.observer,
    this.liveData,
    FLifecycle lifecycle,
  })  : assert(observer != null),
        assert(liveData != null),
        super(lifecycle);

  /// 通知观察者
  void notifyValue(T value) {
    if (isDestroyed) {
      return;
    }
    observer(value);
  }

  @override
  void onDestroy() {
    liveData.removeObserver(observer);
  }
}

class _LazyObserverWrapper<T> extends _ObserverWrapper<T> {
  T _value;
  bool _changed = false;

  _LazyObserverWrapper({
    FLiveDataObserver<T> observer,
    FLiveData liveData,
    FLifecycle lifecycle,
  }) : super(
          observer: observer,
          liveData: liveData,
          lifecycle: lifecycle,
        );

  @override
  void notifyValue(T value) {
    if (_value != value) {
      this._value = value;
      this._changed = true;
    }
    _notifyIfNeed();
  }

  @override
  void onLifecycleEvent(FLifecycleEvent event) {
    super.onLifecycleEvent(event);
    _notifyIfNeed();
  }

  void _notifyIfNeed() {
    if (_changed) {
      if (lifecycle != null) {
        final FLifecycleState state = lifecycle.getCurrentState();
        if (state.index >= FLifecycleState.started.index) {
          _notifyValueReal();
        }
      } else {
        _notifyValueReal();
      }
    }
  }

  void _notifyValueReal() {
    _changed = false;
    super.notifyValue(_value);
  }
}
