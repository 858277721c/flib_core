import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

typedef dynamic FMethodCallHandler(Map<String, dynamic> arguments);

class FMethodChannel {
  static final FMethodChannel global = _FGlobalMethodChannel();

  final MethodChannel _methodChannel;
  final Map<String, FMethodCallHandler> _mapCallHandler = {};

  FMethodChannel(String name)
      : assert(name != null && name.isNotEmpty),
        this._methodChannel = MethodChannel('flutter.fanwe.com/' + name) {
    _methodChannel.setMethodCallHandler(_onMethodCall);
  }

  Future<dynamic> _onMethodCall(MethodCall call) async {
    final FMethodCallHandler handler = _mapCallHandler[call.method];
    if (handler == null) return null;

    assert(call.arguments is String);

    final Map<String, dynamic> arguments = json.decode(call.arguments);
    return handler(arguments);
  }

  /// 监听某个方法触发
  void listen(String method, FMethodCallHandler handler) {
    assert(method != null && method.isNotEmpty);

    if (handler != null) {
      _mapCallHandler[method] = handler;
    } else {
      _mapCallHandler.remove(method);
    }
  }

  /// 调用某个方法
  Future<T> invokeMethod<T>(String method, [dynamic arguments]) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  /// 销毁
  void dispose() {
    _mapCallHandler.clear();
    _methodChannel.setMethodCallHandler(null);
  }
}

class _FGlobalMethodChannel extends FMethodChannel {
  _FGlobalMethodChannel() : super('_global_');

  @override
  void dispose() {}
}
