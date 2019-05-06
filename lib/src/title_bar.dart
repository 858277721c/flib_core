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
  final double height;
  final double elevation;
  final Decoration decoration;

  FTitleBar({
    this.child,
    Color color,
    double height,
    double elevation,
    this.decoration,
  })  : this.color = color ?? FRes.titleBar().backgroundColor,
        this.height = height ?? FRes.titleBar().height,
        this.elevation = elevation ?? 4;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: elevation,
      child: Container(
        decoration: decoration,
        child: getChild(),
      ),
    );
  }

  @protected
  Widget getChild() {
    return child;
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}

/// 分为左，中，右的简单标题栏
class FSimpleTitleBar extends FTitleBar {
  final List<Widget> _list = [];

  FSimpleTitleBar({
    Color color,
    double height,
    double elevation,
    Decoration decoration,
    Widget left,
    Widget middle,
    Widget right,
  }) : super(
          color: color,
          height: height,
          elevation: elevation,
          decoration: decoration,
        ) {
    if (left == null) {
      left = FTitleBarItemBack();
    }

    _addToList(left, Alignment.centerLeft);
    _addToList(middle, Alignment.center);
    _addToList(right, Alignment.centerRight);
  }

  void _addToList(Widget child, AlignmentGeometry alignment) {
    if (child == null) {
      return;
    }
    assert(alignment != null);
    _list.add(SizedBox(
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
      children: _list,
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
  final EdgeInsetsGeometry margin;
  final VoidCallback onClick;

  FTitleBarItem(
    this.child, {
    Color color,
    double minWidth,
    double maxWidth,
    AlignmentGeometry alignment,
    this.padding = const EdgeInsets.only(left: 5, right: 5),
    this.margin,
    this.onClick,
  })  : this.color = color ?? Colors.transparent,
        this.minWidth = minWidth ?? FRes.titleBar().minWidthItem,
        this.maxWidth = maxWidth ?? double.infinity,
        this.alignment = alignment ?? Alignment.center;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: double.infinity,
          maxHeight: double.infinity),
      padding: padding,
      margin: margin,
      child: InkWell(
        child: Stack(
          children: <Widget>[
            _getChild(),
          ],
          alignment: alignment,
        ),
        onTap: onClick == null
            ? null
            : () {
                onClick();
              },
      ),
    );
  }

  Widget _getChild() {
    if (child is Image) {
      final Image imageChild = child as Image;
      if (imageChild.width == null && imageChild.height == null) {
        return SizedBox(
          child: child,
          width: FRes.titleBar().widthItemImage,
          height: FRes.titleBar().heightItemImage,
        );
      }
    }
    return child;
  }
}

/// 标题栏返回item
class FTitleBarItemBack extends StatelessWidget {
  final VoidCallback onClick;

  FTitleBarItemBack({this.onClick});

  @override
  Widget build(BuildContext context) {
    Widget child;

    final String imageBack = FRes.titleBar().imageBack;
    if (imageBack != null && imageBack.isNotEmpty) {
      child = Image.asset(
        imageBack,
        width: FRes.titleBar().widthItemImage,
        height: FRes.titleBar().heightItemImage,
      );
    } else {
      child = Icon(
        Icons.arrow_back_ios,
        size: FRes.titleBar().widthItemImage,
        color: FRes.titleBar().textColor,
      );
    }

    assert(child != null);
    return FTitleBarItem(
      child,
      onClick: onClick ??
          () {
            Navigator.maybePop(context);
          },
    );
  }
}
