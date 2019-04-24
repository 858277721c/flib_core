import 'dart:async';

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
  ObserverCanceller addObserver<T>(void onData(T event)) {
    final Stream<T> stream = T == dynamic
        ? _streamController.stream
        : _streamController.stream.where((event) => event is T).cast<T>();

    return ObserverCanceller(stream.listen(onData));
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
