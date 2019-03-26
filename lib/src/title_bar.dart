import 'package:flutter/material.dart';

import 'res.dart';

class FTitleBarSize extends Size {
  FTitleBarSize({
    double width,
    double height,
  }) : super(
          width ?? double.infinity,
          height ?? FRes.titleBar().height,
        );
}

/// 标题栏容器
class FTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final Color color;
  final double width;
  final double height;

  FTitleBar({
    this.child,
    Color color,
    double width,
    double height,
  })  : this.color = color ?? FRes.titleBar().backgroundColor,
        this.width = width ?? double.infinity,
        this.height = height ?? FRes.titleBar().height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getChild(),
      color: color,
      width: width,
      height: height,
    );
  }

  @protected
  Widget getChild() {
    return child;
  }

  @override
  Size get preferredSize => Size(width, height);
}

/// 分为左，中，右的简单标题栏
class FSimpleTitleBar extends FTitleBar {
  final List<Widget> list = [];

  FSimpleTitleBar({
    Color color,
    double width,
    double height,
    Widget left,
    Widget middle,
    Widget right,
  }) : super(
          color: color,
          width: width,
          height: height,
        ) {
    _addToList(left, Alignment.centerLeft);
    _addToList(middle, Alignment.center);
    _addToList(right, Alignment.centerRight);
  }

  void _addToList(Widget child, AlignmentGeometry alignment) {
    if (child == null) {
      return;
    }
    assert(alignment != null);
    list.add(SizedBox(
      child: Align(
        child: child,
        alignment: alignment,
      ),
      width: double.infinity,
      height: double.infinity,
    ));
  }

  @override
  Widget getChild() {
    return Stack(
      children: list,
      alignment: Alignment.center,
    );
  }
}

/// 标题栏item
class FTitleBarItem extends StatelessWidget {
  final Widget child;
  final Color color;
  final double minWidth;
  final double maxWidth;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final VoidCallback onTap;

  FTitleBarItem(
    this.child, {
    Color color,
    double minWidth,
    double maxWidth,
    AlignmentGeometry alignment,
    this.padding = const EdgeInsets.only(left: 5, right: 5),
    this.onTap,
  })  : this.color = color ?? Colors.transparent,
        this.minWidth = minWidth ?? FRes.titleBar().minWidthItem,
        this.maxWidth = maxWidth ?? double.infinity,
        this.alignment = alignment ?? Alignment.center;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: color,
        constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
            minHeight: double.infinity,
            maxHeight: double.infinity),
        padding: padding,
        child: Stack(
          children: <Widget>[
            child,
          ],
          alignment: alignment,
        ),
      ),
      onTap: onTap,
    );
  }
}

/// 标题栏图标
class FTitleImage extends StatelessWidget {
  final Image image;
  final double width;
  final double height;

  FTitleImage(
    this.image, {
    double width,
    double height,
  })  : assert(image != null),
        this.width = image.width ?? (width ?? FRes.titleBar().widthItemImage),
        this.height =
            image.height ?? (height ?? FRes.titleBar().heightItemImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: image,
      width: width,
      height: height,
    );
  }
}

/// 标题栏文字TextStyle
class FTextStyleTitleBar extends TextStyle {
  FTextStyleTitleBar({
    Color color,
    double fontSize,
  }) : super(
          color: color ?? FRes.titleBar().textColor,
          fontSize: fontSize ?? FRes.titleBar().textSize,
          decoration: TextDecoration.none,
        );
}

/// 标题栏小一号文字TextStyle
class FTextStyleTitleBarSub extends FTextStyleTitleBar {
  FTextStyleTitleBarSub({
    Color color,
    double fontSize,
  }) : super(
          color: color,
          fontSize: fontSize ?? FRes.titleBar().textSizeSub,
        );
}
