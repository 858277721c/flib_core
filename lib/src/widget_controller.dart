import 'package:flutter/material.dart';

class FStatefulWidgetController {
  final GlobalKey<_InternalStatefulWidgetState> _globalKey = GlobalKey();
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
    return _InternalStatefulWidget(
      builder: _builder,
      key: _globalKey,
    );
  }

  /// 刷新ui
  bool update() {
    final State state = _globalKey.currentState;
    if (state != null && state.mounted) {
      state.setState(() {});
      return true;
    }
    return false;
  }
}

class _InternalStatefulWidget extends StatefulWidget {
  final WidgetBuilder builder;

  _InternalStatefulWidget({
    @required this.builder,
    Key key,
  })  : assert(builder != null),
        super(key: key);

  @override
  _InternalStatefulWidgetState createState() => _InternalStatefulWidgetState();
}

class _InternalStatefulWidgetState extends State<_InternalStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
