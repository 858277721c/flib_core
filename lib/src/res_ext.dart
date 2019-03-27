import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      : super.all(Radius.circular(FRes.dimens().cornerRadius));
}

class FBorderRadiusCornerL extends FBorderRadius {
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

class FSystemUiOverlay extends StatefulWidget {
  final Widget child;

  final bool top;
  final Color topColor;
  final Brightness topBrightness;

  final bool bottom;
  final Color bottomColor;
  final Brightness bottomBrightness;

  FSystemUiOverlay({
    @required this.child,
    this.top = true,
    Color topColor,
    this.topBrightness,
    this.bottom = true,
    Color bottomColor,
    this.bottomBrightness,
  })  : assert(child != null),
        assert(top != null),
        assert(bottom != null),
        this.topColor = topColor ?? FRes.titleBar().backgroundColor,
        this.bottomColor = bottomColor ?? Colors.black;

  @override
  State<StatefulWidget> createState() {
    return _FSystemUiOverlayState();
  }
}

class _FSystemUiOverlayState extends State<FSystemUiOverlay> {
  SystemUiOverlayStyle _style;
  bool _resume = true;

  @override
  void initState() {
    super.initState();
    if (widget.top || widget.bottom) {
      Color statusBarColor;
      Brightness statusBarBrightness;
      Brightness statusBarIconBrightness;

      if (widget.top) {
        final bool isDark = widget.topBrightness != null
            ? widget.topBrightness == Brightness.dark
            : widget.topColor.computeLuminance() < 0.5;

        statusBarColor = widget.topColor;
        statusBarBrightness = isDark ? Brightness.dark : Brightness.light;
        statusBarIconBrightness = isDark ? Brightness.light : Brightness.dark;
      }

      Color systemNavigationBarColor;
      Brightness systemNavigationBarIconBrightness;

      if (widget.bottom) {
        final bool isDark = widget.bottomBrightness != null
            ? widget.bottomBrightness == Brightness.dark
            : widget.bottomColor.computeLuminance() < 0.5;

        systemNavigationBarColor = widget.bottomColor;
        systemNavigationBarIconBrightness =
            isDark ? Brightness.light : Brightness.dark;
      }

      _style = SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarBrightness: statusBarBrightness,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      );
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    _resume = !_resume;
  }

  @override
  Widget build(BuildContext context) {
    if (_resume && _style != null) {
      SystemChrome.setSystemUIOverlayStyle(_style);
    }

    return widget.child;
  }
}
