import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class FState<T extends StatefulWidget> extends State<T> {
  @mustCallSuper
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
        this.topColor = topColor ?? Colors.transparent,
        this.bottomColor = bottomColor ?? Colors.black;

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
    if (widget.top || widget.bottom) {
      Color statusBarColor;
      Brightness statusBarBrightness;
      Brightness statusBarIconBrightness;

      if (widget.top) {
        final bool isDark = _isDark(
          brightness: widget.topBrightness,
          color: widget.topColor,
        );

        assert(isDark != null);
        statusBarColor = widget.topColor;
        statusBarBrightness = isDark ? Brightness.dark : Brightness.light;
        statusBarIconBrightness = isDark ? Brightness.light : Brightness.dark;
      }

      Color systemNavigationBarColor;
      Brightness systemNavigationBarIconBrightness;

      if (widget.bottom) {
        final bool isDark = _isDark(
          brightness: widget.bottomBrightness,
          color: widget.bottomColor,
        );

        assert(isDark != null);
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

  bool _isDark({Brightness brightness, Color color}) {
    if (brightness != null) {
      return brightness == Brightness.dark;
    }
    if (color == Colors.transparent) {
      return true;
    }
    return color.computeLuminance() < 0.5;
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
