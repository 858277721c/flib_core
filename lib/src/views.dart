import 'package:flutter/material.dart';

class FAlignmentStack extends StatelessWidget {
  final List<Widget> list = [];

  final List<Widget> childrenTopLeft;
  final List<Widget> childrenTopCenter;
  final List<Widget> childrenTopRight;

  final List<Widget> childrenCenterLeft;
  final List<Widget> childrenCenter;
  final List<Widget> childrenCenterRight;

  final List<Widget> childrenBottomLeft;
  final List<Widget> childrenBottomCenter;
  final List<Widget> childrenBottomRight;

  FAlignmentStack({
    this.childrenTopLeft,
    this.childrenTopCenter,
    this.childrenTopRight,
    this.childrenCenterLeft,
    this.childrenCenter,
    this.childrenCenterRight,
    this.childrenBottomLeft,
    this.childrenBottomCenter,
    this.childrenBottomRight,
  }) {
    _addToListIfNeed(list, childrenTopLeft, Alignment.topLeft);
    _addToListIfNeed(list, childrenTopCenter, Alignment.topCenter);
    _addToListIfNeed(list, childrenTopRight, Alignment.topRight);

    _addToListIfNeed(list, childrenCenterLeft, Alignment.centerLeft);
    _addToListIfNeed(list, childrenCenter, Alignment.center);
    _addToListIfNeed(list, childrenCenterRight, Alignment.centerRight);

    _addToListIfNeed(list, childrenBottomLeft, Alignment.bottomLeft);
    _addToListIfNeed(list, childrenBottomCenter, Alignment.bottomCenter);
    _addToListIfNeed(list, childrenBottomRight, Alignment.bottomRight);
  }

  static void _addToListIfNeed(
    List<Widget> list,
    List<Widget> children,
    AlignmentGeometry alignment,
  ) {
    assert(list != null);
    assert(alignment != null);

    if (children != null && children.isNotEmpty) {
      list.add(new SizedBox(
        child: new Stack(
          alignment: alignment,
          children: children,
        ),
        width: double.infinity,
        height: double.infinity,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: list,
      alignment: Alignment.center,
    );
  }
}
