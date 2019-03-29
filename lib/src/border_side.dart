import 'package:flutter/material.dart';

import 'res.dart';

class FBorderSide {
  FBorderSide._();

  static BorderSide base({
    Color color,
    double width,
    BorderStyle style,
  }) {
    width ??= FRes.dimens().widthDivider;
    style ??= BorderStyle.none;

    return BorderSide(
      color: color,
      width: width,
      style: style,
    );
  }

  static BorderSide divider({
    Color color,
    double width,
    BorderStyle style,
  }) {
    color ??= FRes.colors().divider;

    return BorderSide(
      color: color,
      width: width,
      style: style,
    );
  }

  static BorderSide mainColor({
    Color color,
    double width,
    BorderStyle style,
  }) {
    color ??= FRes.colors().mainColor;

    return BorderSide(
      color: color,
      width: width,
      style: style,
    );
  }

  static BorderSide mainColorDisabled({
    Color color,
    double width,
    BorderStyle style,
  }) {
    color ??= FRes.colors().mainColorDisabled;

    return BorderSide(
      color: color,
      width: width,
      style: style,
    );
  }
}
