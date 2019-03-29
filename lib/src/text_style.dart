import 'package:flutter/material.dart';

import 'res.dart';

class FTextStyle {
  FTextStyle._();

  static TextStyle base({
    Color color,
    double fontSize,
    TextDecoration decoration,
  }) {
    decoration ??= TextDecoration.none;

    return TextStyle(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
  }

  static TextStyle mainColor({
    Color color,
    double fontSize,
    TextDecoration decoration,
  }) {
    color ??= FRes.colors().mainColor;

    return base(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
  }

  static TextStyle mainColorDisabled({
    Color color,
    double fontSize,
    TextDecoration decoration,
  }) {
    color ??= FRes.colors().mainColorDisabled;

    return base(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
  }

  static TextStyle textGrayL({
    Color color,
    double fontSize,
    TextDecoration decoration,
  }) {
    color ??= FRes.colors().textGrayL;

    return base(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
  }

  static TextStyle textGrayM({
    Color color,
    double fontSize,
    TextDecoration decoration,
  }) {
    color ??= FRes.colors().textGrayM;

    return base(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
  }

  static TextStyle textGrayS({
    Color color,
    double fontSize,
    TextDecoration decoration,
  }) {
    color ??= FRes.colors().textGrayS;

    return base(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
  }

  static TextStyle textHint({
    Color color,
    double fontSize,
    TextDecoration decoration,
  }) {
    color ??= FRes.colors().textHint;

    return base(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
  }
}
