import 'package:flutter/material.dart';

import 'res.dart';

class FTitleBarSize extends Size {
  FTitleBarSize({
    double width,
    double height,
  }) : super(
          width ?? double.infinity,
          height ?? FRes.dimens().heightTitleBar,
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
  })  : this.color = color ?? FRes.colors().bgTitleBar,
        this.width = width ?? double.infinity,
        this.height = height ?? FRes.dimens().heightTitleBar;

  @override
  Widget build(BuildContext context) {
    return new Container(
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
  Size get preferredSize => new Size(width, height);
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
    list.add(new SizedBox(
      child: new Stack(
        alignment: alignment,
        children: <Widget>[child],
      ),
      width: double.infinity,
      height: double.infinity,
    ));
  }

  @override
  Widget getChild() {
    return new Stack(
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
        this.minWidth = minWidth ?? FRes.dimens().minWidthTitleBarItem,
        this.maxWidth = maxWidth ?? double.infinity,
        this.alignment = alignment ?? Alignment.center;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        color: color,
        constraints: new BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
            minHeight: double.infinity,
            maxHeight: double.infinity),
        padding: padding,
        child: new Stack(
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
        this.width =
            image.width ?? (width ?? FRes.dimens().widthTitleBarItemImage),
        this.height =
            image.height ?? (height ?? FRes.dimens().heightTitleBarItemImage);

  @override
  Widget build(BuildContext context) {
    return new Container(
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
          color: color ?? FRes.colors().textTitleBar,
          fontSize: fontSize ?? FRes.dimens().textTitleBar,
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
          fontSize: fontSize ?? FRes.dimens().textTitleBarSub,
        );
}
