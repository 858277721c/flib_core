import 'package:flutter/material.dart';

import 'res.dart';

class FDivider extends StatelessWidget {
  final Color color;
  final double size;
  final EdgeInsetsGeometry margin;
  final bool horizontal;

  FDivider({
    Color color,
    double size,
    this.margin,
    this.horizontal = true,
  })  : assert(horizontal != null),
        this.color = color ?? FRes.colors().divider,
        this.size = size ?? FRes.dimens().widthDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: horizontal ? double.infinity : size,
      height: horizontal ? size : double.infinity,
      margin: margin,
    );
  }
}

class FSafeArea extends StatelessWidget {
  final Widget child;

  final bool top;
  final Color topColor;

  final bool bottom;
  final Color bottomColor;

  FSafeArea({
    @required this.child,
    this.top = true,
    Color topColor,
    this.bottom = true,
    Color bottomColor,
  })  : assert(child != null),
        assert(top != null),
        assert(bottom != null),
        this.topColor = topColor ?? FRes.titleBar().backgroundColor,
        this.bottomColor = bottomColor ?? FRes.colors().bgPage;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final List<Widget> list = [];

    if (top && padding.top > 0) {
      list.add(Container(
        color: topColor,
        height: padding.top,
      ));
    }

    list.add(Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: top,
        removeBottom: bottom,
        removeLeft: true,
        removeRight: true,
        child: child,
      ),
    ));

    if (bottom && padding.bottom > 0) {
      list.add(Container(
        color: bottomColor,
        height: padding.bottom,
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: list,
    );
  }
}
