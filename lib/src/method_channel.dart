import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

typedef dynamic FMethodCallHandler(Map<String, dynamic> arguments);

class FMethodChannel {
  static final FGlobalMethodChannel global = FGlobalMethodChannel._();
  static final FStateLifecycleChannel stateLifecycle =
      FStateLifecycleChannel._();

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

class FGlobalMethodChannel extends FMethodChannel {
  FGlobalMethodChannel._() : super('global');

  @override
  void dispose() {}
}

class FStateLifecycleChannel extends FMethodChannel {
  FStateLifecycleChannel._() : super("stateLifecycle");

  void onCreate(String stateName) {
    assert(stateName != null && stateName.isNotEmpty);
    invokeMethod("onCreate", {
      "name": stateName,
    });
  }

  void onStart(String stateName) {
    assert(stateName != null && stateName.isNotEmpty);
    invokeMethod("onStart", {
      "name": stateName,
    });
  }

  void onStop(String stateName) {
    assert(stateName != null && stateName.isNotEmpty);
    invokeMethod("onStop", {
      "name": stateName,
    });
  }

  void onDestroy(String stateName) {
    assert(stateName != null && stateName.isNotEmpty);
    invokeMethod("onDestroy", {
      "name": stateName,
    });
  }

  @override
  void dispose() {}
}
