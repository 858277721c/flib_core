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
    return new Container(
      color: color,
      width: horizontal ? double.infinity : size,
      height: horizontal ? size : double.infinity,
      margin: margin,
    );
  }
}