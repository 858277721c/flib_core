import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.topColor = Colors.transparent,
    this.topBrightness,
    this.bottom = true,
    this.bottomColor = Colors.black,
    this.bottomBrightness,
  })  : assert(child != null),
        assert(top != null),
        assert(bottom != null);

  SystemUiOverlayStyle newStyle() {
    if (top || bottom) {
      Color statusBarColor;
      Brightness statusBarBrightness;
      Brightness statusBarIconBrightness;

      if (top) {
        final bool isDark = _isDark(
          brightness: topBrightness,
          color: topColor,
        );

        assert(isDark != null);
        statusBarColor = topColor;
        statusBarBrightness = isDark ? Brightness.dark : Brightness.light;
        statusBarIconBrightness = isDark ? Brightness.light : Brightness.dark;
      }

      Color systemNavigationBarColor;
      Brightness systemNavigationBarIconBrightness;

      if (bottom) {
        final bool isDark = _isDark(
          brightness: bottomBrightness,
          color: bottomColor,
        );

        assert(isDark != null);
        systemNavigationBarColor = bottomColor;
        systemNavigationBarIconBrightness =
            isDark ? Brightness.light : Brightness.dark;
      }

      return SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarBrightness: statusBarBrightness,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      );
    }
    return null;
  }

  bool _isDark({Brightness brightness, Color color}) {
    if (brightness != null) {
      return brightness == Brightness.dark;
    }
    if (color == null || color.alpha != 0xFF) {
      return true;
    }
    return ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
  }

  @override
  State<StatefulWidget> createState() {
    return _FSystemUiOverlayState();
  }
}

class _FSystemUiOverlayState extends State<FSystemUiOverlay> {
  SystemUiOverlayStyle _style;

  @override
  void initState() {
    super.initState();
    _style = widget.newStyle();
  }

  @override
  Widget build(BuildContext context) {
    if (_style == null) {
      return widget.child;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: widget.child,
      value: _style,
    );
  }
}
