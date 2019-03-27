import 'package:flutter/material.dart';

abstract class FState<T extends StatefulWidget> extends State<T> {
  @mustCallSuper
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
