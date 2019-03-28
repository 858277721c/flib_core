import 'package:flutter/material.dart';

import 'res.dart';
import 'res_ext.dart';

class FTheme {
  FTheme._();

  static ThemeData themeData() {
    return ThemeData(
      primaryColor: FRes.colors().mainColor,
      accentColor: FRes.colors().mainColor,
      scaffoldBackgroundColor: FRes.colors().bgPage,
      buttonTheme: buttonThemeData(),
      appBarTheme: appBarTheme(),
    );
  }

  static ButtonThemeData buttonThemeData() {
    return ButtonThemeData(
      minWidth: 0,
      height: FRes.dimens().heightButton,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: FBorderRadiusCorner(),
      ),
      buttonColor: FRes.colors().mainColor,
      disabledColor: FRes.colors().mainColor.withOpacity(0.6),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      color: FRes.titleBar().backgroundColor,
      brightness: FRes.titleBar().brightness,
    );
  }
}
