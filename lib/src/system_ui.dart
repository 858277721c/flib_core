import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FSystemUiOverlay extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle style;

  FSystemUiOverlay({
    @required this.child,
    SystemUiOverlayStyle style,
  })  : assert(child != null),
        this.style = style ??
            SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: child,
      value: style,
    );
  }
}
