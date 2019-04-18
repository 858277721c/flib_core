import 'package:flutter/material.dart';

class FStatefulWidgetController {
  final GlobalKey<_InternalStatefulWidgetState> _globalKey = GlobalKey();
  Widget _widget;

  void _setWidget(Widget widget) {
    assert(widget != null);
    this._widget = widget;
  }

  /// 创建并返回一个StatefulWidget对象，传入的Widget对象为需要展示的UI
  StatefulWidget init(Widget initWidget) {
    _setWidget(initWidget);

    return _InternalStatefulWidget(
      builder: (context) {
        return _widget;
      },
      key: _globalKey,
    );
  }

  /// 用传入的Widget对象更新UI
  bool update(Widget updateWidget) {
    _setWidget(updateWidget);

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
