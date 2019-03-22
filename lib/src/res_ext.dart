import 'package:flutter/material.dart';

import 'res.dart';

class FTextStyle extends TextStyle {
  FTextStyle({
    Color color,
    double fontSize,
  }) : super(
          color: color,
          fontSize: fontSize,
          decoration: TextDecoration.none,
        );
}

class FTextStyleMainColor extends FTextStyle {
  FTextStyleMainColor({
    Color color,
    double fontSize,
  }) : super(
          color: color ?? FRes.colors().mainColor,
          fontSize: fontSize,
        );
}

class FTextStyleGrayL extends FTextStyle {
  FTextStyleGrayL({
    Color color,
    double fontSize,
  }) : super(
          color: color ?? FRes.colors().textGrayL,
          fontSize: fontSize,
        );
}

class FTextStyleGrayM extends FTextStyle {
  FTextStyleGrayM({
    Color color,
    double fontSize,
  }) : super(
          color: color ?? FRes.colors().textGrayM,
          fontSize: fontSize,
        );
}

class FTextStyleGrayS extends FTextStyle {
  FTextStyleGrayS({
    Color color,
    double fontSize,
  }) : super(
          color: color ?? FRes.colors().textGrayS,
          fontSize: fontSize,
        );
}

class FTextStyleHint extends FTextStyle {
  FTextStyleHint({
    Color color,
    double fontSize,
  }) : super(
          color: color ?? FRes.colors().textHint,
          fontSize: fontSize,
        );
}

class FRoundedRectangleBorderL extends RoundedRectangleBorder {
  FRoundedRectangleBorderL({
    BorderSide side = BorderSide.none,
    BorderRadiusGeometry borderRadius,
  }) : super(
          side: side,
          borderRadius: borderRadius ??
              BorderRadius.circular(FRes.dimens().cornerRadiusL),
        );
}

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
