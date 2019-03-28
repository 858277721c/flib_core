import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FSystemUiOverlay extends StatefulWidget {
  final Widget child;
  final FSystemUiOverlayStyle style;

  FSystemUiOverlay({
    @required this.child,
    this.style = const FSystemUiOverlayStyle(),
  })  : assert(child != null),
        assert(style != null);

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
    _style = widget.style.build();
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

class FSystemUiOverlayStyle {
  final bool top;
  final Color topColor;
  final Brightness topBrightness;

  final bool bottom;
  final Color bottomColor;
  final Brightness bottomBrightness;

  const FSystemUiOverlayStyle({
    this.top = true,
    this.topColor = Colors.transparent,
    this.topBrightness,
    this.bottom = true,
    this.bottomColor = Colors.black,
    this.bottomBrightness,
  })  : assert(top != null),
        assert(bottom != null);

  FSystemUiOverlayStyle copyWith({
    bool top,
    Color topColor,
    Brightness topBrightness,
    bool bottom,
    Color bottomColor,
    Brightness bottomBrightness,
  }) {
    return FSystemUiOverlayStyle(
      top: top ?? this.top,
      topColor: topColor ?? this.topColor,
      topBrightness: topBrightness ?? this.topBrightness,
      bottom: bottom ?? this.bottom,
      bottomColor: bottomColor ?? this.bottomColor,
      bottomBrightness: bottomBrightness ?? this.bottomBrightness,
    );
  }

  /// 应用当前style
  void apply() {
    final SystemUiOverlayStyle style = build();
    if (style != null) {
      SystemChrome.setSystemUIOverlayStyle(style);
    }
  }

  /// 构建一个原生的[SystemUiOverlayStyle]对象，可能返回null
  SystemUiOverlayStyle build() {
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
}
