import 'package:flutter/material.dart';

import 'res.dart';

//---------- TextStyle ----------

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

//---------- BorderSide ----------

class FBorderSide extends BorderSide {
  FBorderSide({
    Color color,
    double width,
    BorderStyle style,
  })  : assert(color != null),
        super(
          color: color,
          width: width ?? FRes.dimens().widthDivider,
          style: style ?? BorderStyle.solid,
        );
}

class FBorderSideDivider extends FBorderSide {
  FBorderSideDivider({
    Color color,
    double width,
    BorderStyle style,
  }) : super(
          color: color ?? FRes.colors().divider,
          width: width,
          style: style,
        );
}

class FBorderSideMainColor extends FBorderSide {
  FBorderSideMainColor({
    Color color,
    double width,
    BorderStyle style,
  }) : super(
          color: color ?? FRes.colors().mainColor,
          width: width,
          style: style,
        );
}

//---------- BorderRadius ----------

class FBorderRadiusCorner extends BorderRadius {
  FBorderRadiusCorner()
      : super.all(Radius.circular(FRes.dimens().cornerRadius));
}

class FBorderRadiusCornerL extends BorderRadius {
  FBorderRadiusCornerL()
      : super.all(Radius.circular(FRes.dimens().cornerRadiusL));
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
