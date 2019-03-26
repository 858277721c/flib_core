import 'package:flutter/material.dart';

import 'res.dart';
import 'res_ext.dart';

class FButtonThemeData extends ButtonThemeData {
  FButtonThemeData()
      : super(
          height: FRes.dimens().heightButton,
          buttonColor: FRes.colors().mainColor,
          disabledColor: FRes.colors().mainColor.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: FBorderRadiusCorner(),
          ),
        );
}
