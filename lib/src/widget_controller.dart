import 'package:flutter/material.dart';

class FStatefulWidgetController {
  final GlobalKey<_InternalWidgetState> _globalKey = GlobalKey();
  WidgetBuilder _builder;

  /// 初始化，设置一个ui构建对象
  void init(WidgetBuilder builder) {
    assert(builder != null);
    assert(this._builder == null);
    this._builder = builder;
  }

  /// 创建一个ui返回
  StatefulWidget newWidget() {
    assert(this._builder != null);
    return _InternalWidget(
      builder: _builder,
      key: _globalKey,
    );
  }

  /// 刷新ui
  bool update() {
    final _InternalWidgetState state = _globalKey.currentState;
    if (state != null) {
      state.update();
      return true;
    }
    return false;
  }
}

class _InternalWidget extends StatefulWidget {
  final WidgetBuilder builder;

  _InternalWidget({
    @required this.builder,
    Key key,
  })  : assert(builder != null),
        super(key: key);

  @override
  _InternalWidgetState createState() => _InternalWidgetState();
}

class _InternalWidgetState extends State<_InternalWidget> {
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
