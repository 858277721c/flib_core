import 'package:flutter/material.dart';

import 'res.dart';

class FButton {
  FButton._();

  static RaisedButton raised({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
  }) {
    /// textColor
    textColor ??= Colors.white;
    disabledTextColor ??= textColor;

    /// color
    color ??= FRes.colors().mainColor;
    disabledColor ??= FRes.colors().mainColorDisabled;

    /// elevation
    elevation ??= 0;
    highlightElevation ??= elevation;
    disabledElevation ??= 0;

    materialTapTargetSize ??= MaterialTapTargetSize.shrinkWrap;

    return RaisedButton(
      key: key,
      onPressed: onPressed,
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: color,
      disabledColor: disabledColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: padding,
      clipBehavior: clipBehavior,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      child: child,
    );
  }

  static FlatButton flat({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    @required Widget child,
  }) {
    /// textColor
    textColor ??= FRes.colors().mainColor;
    disabledTextColor ??= FRes.colors().mainColorDisabled;

    materialTapTargetSize ??= MaterialTapTargetSize.shrinkWrap;

    return FlatButton(
      key: key,
      onPressed: onPressed,
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: color,
      disabledColor: disabledColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      padding: padding,
      shape: shape,
      clipBehavior: clipBehavior,
      materialTapTargetSize: materialTapTargetSize,
      child: child,
    );
  }

  static OutlineButton outline({
    Key key,
    @required VoidCallback onPressed,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color highlightColor,
    Color splashColor,
    double highlightElevation,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    Widget child,

    ///
    BorderSide borderSide,
    Color disabledBorderColor,
    Color highlightedBorderColor,
  }) {
    borderSide ??= BorderSide(
      color: FRes.colors().mainColor,
      width: 1,
    );
    disabledBorderColor ??= FRes.colors().mainColorDisabled;
    highlightedBorderColor ??= FRes.colors().mainColor;

    return OutlineButton(
      key: key,
      onPressed: onPressed,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: color,
      highlightColor: highlightColor,
      splashColor: splashColor,
      highlightElevation: highlightElevation,
      padding: padding,
      shape: shape,
      clipBehavior: clipBehavior,
      child: child,

      ///
      borderSide: borderSide,
      disabledBorderColor: disabledBorderColor,
      highlightedBorderColor: highlightedBorderColor,
    );
  }
}
