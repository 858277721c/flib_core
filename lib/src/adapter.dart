import 'package:flutter/material.dart';

abstract class FListAdapter<T> {
  final List<T> listModel;

  FListAdapter({List<T> listModel}) : this.listModel = listModel ?? [];

  Widget build(BuildContext context, int index) {
    if (index < 0 || index >= listModel.length) {
      return null;
    }

    return buildImpl(context, index, listModel[index]);
  }

  @protected
  Widget buildImpl(BuildContext context, int index, T model);
}
