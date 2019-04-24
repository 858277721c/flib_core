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

  /// 添加事件观察者
  ObserverCanceller addObserver<T>(
      void onData(T event), FLifecycleOwner lifecycleOwner) {
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
  void post(dynamic event) {
    _streamController.add(event);
  }
}

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
