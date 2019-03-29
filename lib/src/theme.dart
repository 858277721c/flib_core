import 'package:flutter/material.dart';

import 'border_radius.dart';
import 'res.dart';

class FTheme {
  FTheme._();

  static ThemeData themeData() {
    final Color mainColor = FRes.colors().mainColor;
    return ThemeData(
      primaryColor: mainColor,
      scaffoldBackgroundColor: FRes.colors().bgPage,
      buttonTheme: buttonThemeDataPrimary(),
      appBarTheme: appBarTheme(),
    );
  }

  static ButtonThemeData buttonThemeData() {
    return ButtonThemeData(
      minWidth: 0,
      height: FRes.dimens().heightButton,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: FBorderRadius.corner(),
      ),
    );
  }

  static ButtonThemeData buttonThemeDataPrimary() {
    final Color mainColor = FRes.colors().mainColor;
    return buttonThemeData().copyWith(
      textTheme: ButtonTextTheme.primary,
      buttonColor: mainColor,
      colorScheme: ColorScheme.light().copyWith(
        primary: mainColor,
        onSurface: mainColor,
      ),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      color: FRes.titleBar().backgroundColor,
      brightness: FRes.titleBar().brightness,
    );
  }
}
