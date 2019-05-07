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
        this.elevation = elevation ?? 0;

  @override
  Widget build(BuildContext context) {
    Widget current = Container(
      width: double.infinity,
      height: height,
      decoration: decoration,
      child: getChild(context),
    );

    current = Material(
      color: color,
      elevation: elevation,
      child: current,
    );

    return current;
  }

  @protected
  Widget getChild(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}

/// 分为（左，中，右）三层层叠的标题栏
class FSimpleTitleBar extends FTitleBar {
  final Widget left;
  final Widget middle;
  final List<Widget> right;

  FSimpleTitleBar({
    this.left,
    this.middle,
    this.right,
    Color color,
    double height,
    double elevation,
    Decoration decoration,
  }) : super(
          color: color,
          height: height,
          elevation: elevation,
          decoration: decoration,
        );

  @override
  Widget getChild(BuildContext context) {
    return _SimpleTitleView(
      left: left,
      middle: middle,
      right: right,
    );
  }
}

class _SimpleTitleView extends StatelessWidget {
  final Widget left;
  final Widget middle;
  final List<Widget> right;

  _SimpleTitleView({
    this.left,
    this.middle,
    this.right,
  });

  void _addToList(
      Widget child, AlignmentGeometry alignment, List<Widget> list) {
    if (child == null) {
      return;
    }
    assert(alignment != null);
    list.add(Container(
      child: child,
      alignment: alignment,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    Widget widgetLeft = left;
    if (widgetLeft == null) {
      widgetLeft = FTitleBarItemBack();
    } else {
      widgetLeft = DefaultTextStyle(
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: FRes.titleBar().textSizeSub,
          color: FRes.titleBar().textColor,
        ),
        child: widgetLeft,
      );
    }

    Widget widgetMiddle = middle;
    if (widgetMiddle != null) {
      widgetMiddle = DefaultTextStyle(
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: FRes.titleBar().textSize,
          color: FRes.titleBar().textColor,
        ),
        child: widgetMiddle,
      );
    }

    Widget widgetRight;
    if (right != null) {
      if (right.length > 1) {
        widgetRight = Row(
          mainAxisSize: MainAxisSize.min,
          children: right,
        );
      } else {
        widgetRight = right[0];
      }
    }

    if (widgetRight != null) {
      widgetRight = DefaultTextStyle(
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: FRes.titleBar().textSizeSub,
          color: FRes.titleBar().textColor,
        ),
        child: widgetRight,
      );
    }

    _addToList(widgetLeft, Alignment.centerLeft, list);
    _addToList(widgetMiddle, Alignment.center, list);
    _addToList(widgetRight, Alignment.centerRight, list);

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
    Widget current = Stack(
      children: <Widget>[
        _getChild(),
      ],
      alignment: alignment,
    );

    current = Container(
      color: color,
      constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: double.infinity,
          maxHeight: double.infinity),
      padding: padding,
      margin: margin,
      child: current,
    );

    current = InkWell(
      child: current,
      onTap: onClick == null
          ? null
          : () {
              onClick();
            },
    );

    return current;
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
