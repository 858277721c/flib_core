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
    double fontSize,
  }) : super(
          color: FRes.colors().mainColor,
          fontSize: fontSize,
        );
}

class FTextStyleMainColorDisabled extends FTextStyle {
  FTextStyleMainColorDisabled({
    double fontSize,
  }) : super(
          color: FRes.colors().mainColorDisabled,
          fontSize: fontSize,
        );
}

class FTextStyleGrayL extends FTextStyle {
  FTextStyleGrayL({
    double fontSize,
  }) : super(
          color: FRes.colors().textGrayL,
          fontSize: fontSize,
        );
}

class FTextStyleGrayM extends FTextStyle {
  FTextStyleGrayM({
    double fontSize,
  }) : super(
          color: FRes.colors().textGrayM,
          fontSize: fontSize,
        );
}

class FTextStyleGrayS extends FTextStyle {
  FTextStyleGrayS({
    double fontSize,
  }) : super(
          color: FRes.colors().textGrayS,
          fontSize: fontSize,
        );
}

class FTextStyleHint extends FTextStyle {
  FTextStyleHint({
    double fontSize,
  }) : super(
          color: FRes.colors().textHint,
          fontSize: fontSize,
        );
}

//---------- BorderSide ----------

class FBorderSide extends BorderSide {
  FBorderSide({
    Color color,
    double width,
  })  : assert(color != null),
        super(
          color: color,
          width: width ?? FRes.dimens().widthDivider,
          style: BorderStyle.solid,
        );
}

class FBorderSideDivider extends FBorderSide {
  FBorderSideDivider({
    double width,
  }) : super(
          color: FRes.colors().divider,
          width: width,
        );
}

class FBorderSideMainColor extends FBorderSide {
  FBorderSideMainColor({
    double width,
  }) : super(
          color: FRes.colors().mainColor,
          width: width,
        );
}

class FBorderSideMainColorDisabled extends FBorderSide {
  FBorderSideMainColorDisabled({
    double width,
  }) : super(
          color: FRes.colors().mainColorDisabled,
          width: width,
        );
}

//---------- BorderRadius ----------

class FBorderRadius extends BorderRadius {
  FBorderRadius.only({
    Radius topLeft,
    Radius topRight,
    Radius bottomLeft,
    Radius bottomRight,
  }) : super.only(
          topLeft: topLeft ?? Radius.zero,
          topRight: topRight ?? Radius.zero,
          bottomLeft: bottomLeft ?? Radius.zero,
          bottomRight: bottomRight ?? Radius.zero,
        );

  FBorderRadius.all(Radius radius)
      : this.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );

  FBorderRadius copyWith({
    Radius topLeft,
    Radius topRight,
    Radius bottomLeft,
    Radius bottomRight,
  }) {
    return FBorderRadius.only(
      topLeft: topLeft ?? this.topLeft,
      topRight: topRight ?? this.topRight,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      bottomRight: bottomRight ?? this.bottomRight,
    );
  }
}

class FBorderRadiusCorner extends FBorderRadius {
  FBorderRadiusCorner()
      : super.all(Radius.circular(FRes.dimens().radiusCorner));
}

class FBorderRadiusCornerL extends FBorderRadius {
  FBorderRadiusCornerL()
      : super.all(Radius.circular(FRes.dimens().radiusCornerL));
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
