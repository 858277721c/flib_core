import 'package:flutter/material.dart';

import 'res.dart';

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
      : super.all(Radius.circular(FRes.dimens().radiusCorner));
}

class FBorderRadiusCornerL extends FBorderRadius {
  FBorderRadiusCornerL()
      : super.all(Radius.circular(FRes.dimens().radiusCornerL));
}
