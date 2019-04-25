import 'dart:async';

import 'package:flib_lifecycle/flib_lifecycle.dart';

class FEventBus {
  static FEventBus _default;

  final StreamController _streamController;

  FEventBus._()
      : this._streamController = StreamController.broadcast(sync: true);

  static FEventBus getDefault() {
    if (_default == null) {
      _default = FEventBus._();
    }
    return _default;
  }

  /// 添加观察者
  ///
  /// 当[lifecycleOwner]对象分发[FLifecycleEvent.onDestroy]事件后，会自动移除观察者
  ///
  /// - [T] 需要观察的事件类型，如果不指定，则表示观察所有事件
  /// - [onData] 观察者
  /// - [lifecycleOwner] 生命周期持有者
  ObserverCanceller addObserver<T>(
    void onData(T event),
    FLifecycleOwner lifecycleOwner,
  ) {
    final Stream<T> stream = T == dynamic
        ? _streamController.stream
        : _streamController.stream.where((event) => event is T).cast<T>();

    FLifecycle lifecycle;
    if (lifecycleOwner != null) {
      lifecycle = lifecycleOwner.getLifecycle();
      assert(lifecycle != null);
    }

    final ObserverCanceller canceller =
        ObserverCanceller(stream.listen(onData));

    _CancellerWrapper(
      canceller: canceller,
      lifecycle: lifecycle,
    );

    return canceller;
  }

  /// 发送事件
  ///
  /// - [event] 要发送的事件
  void post(dynamic event) {
    _streamController.add(event);
  }
}

/// 观察者取消对象，可以取消添加的观察者
class ObserverCanceller {
  final StreamSubscription _streamSubscription;

  ObserverCanceller(StreamSubscription streamSubscription)
      : assert(streamSubscription != null),
        this._streamSubscription = streamSubscription;

  /// 取消监听
  void cancel() {
    _streamSubscription.cancel();
  }
}

class _CancellerWrapper extends FLifecycleWrapper {
  final ObserverCanceller canceller;

  _CancellerWrapper({
    this.canceller,
    FLifecycle lifecycle,
  })  : assert(canceller != null),
        super(lifecycle);

  @override
  void onDestroy() {
    canceller.cancel();
  }
}
