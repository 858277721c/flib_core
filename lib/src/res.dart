import 'package:flutter/material.dart';

class FRes {
  static FRes _instance;

  FResColors _colors;
  FResDimens _dimens;
  FResTitleBar _titleBar;

  FRes._internal() {
    _colors = FResColors();
    _dimens = FResDimens();
    _titleBar = FResTitleBar();
  }

  static FRes getInstance() {
    if (_instance == null) {
      _instance = FRes._internal();
    }
    return _instance;
  }

  void init({FResColors colors, FResDimens dimens, FResTitleBar titleBar}) {
    if (colors != null) {
      _colors = colors;
    }
    if (dimens != null) {
      _dimens = dimens;
    }
    if (titleBar != null) {
      _titleBar = titleBar;
    }
  }

  static FResColors colors() {
    return getInstance()._colors;
  }

  static FResDimens dimens() {
    return getInstance()._dimens;
  }

  static FResTitleBar titleBar() {
    return getInstance()._titleBar;
  }
}

class FResColors {
  /// 主题色
  final Color mainColor;

  /// 主题色不可用状态的颜色
  final Color mainColorDisabled;

  /// 页面背景色
  final Color bgPage;

  /// 灰色文字（深）
  final Color textGrayL;

  /// 灰色文字（中）
  final Color textGrayM;

  /// 灰色文字（浅）
  final Color textGrayS;

  /// 提示文字（常用在输入框）
  final Color textHint;

  /// 选项卡文字颜色（正常状态）
  final Color textTabNormal;

  /// 选项卡文字颜色（选中状态）
  final Color textTabSelected;

  /// 文字阴影颜色
  final Color shadowText;

  /// 分割线颜色
  final Color divider;

  FResColors({
    this.mainColor = Colors.blue,
    this.bgPage = const Color(0xFFF7F7F7),
    this.textGrayL = const Color(0xFF333333),
    this.textGrayM = const Color(0xFF666666),
    this.textGrayS = const Color(0xFF999999),
    this.textHint = const Color(0xFFCBCBCB),
    Color textTabNormal,
    Color textTabSelected,
    this.shadowText = const Color(0xFF333333),
    this.divider = const Color(0xFFE7E7F1),
  })  : assert(mainColor != null),
        this.mainColorDisabled = mainColor.withOpacity(0.5),
        this.textTabNormal = textTabNormal ?? textGrayS,
        this.textTabSelected = textTabSelected ?? mainColor;
}

class FResDimens {
  /// 通用按钮高度
  final double heightButton;

  /// 通用输入框高度
  final double heightTextField;

  /// 边框粗细
  final double widthDivider;

  /// 输入框边框粗细
  final double widthTextFieldBorder;

  /// 圆角半径
  final double radiusCorner;

  /// 圆角半径（大）
  final double radiusCornerL;

  FResDimens({
    this.heightButton = 36,
    this.heightTextField = 40,
    this.widthDivider = 0.5,
    this.widthTextFieldBorder = 0.5,
    this.radiusCorner = 5,
    this.radiusCornerL = 18,
  });
}

class FResTitleBar {
  /// 标题栏背景色
  final Color backgroundColor;

  final Brightness brightness;

  /// 标题栏文字颜色
  final Color textColor;

  /// 返回按钮
  final String imageBack;

  /// 标题栏高度
  final double height;

  /// 标题栏文字大小
  final double textSize;

  /// 标题栏小一号文字大小
  final double textSizeSub;

  /// 标题栏item的最小宽度
  final double minWidthItem;

  /// 标题栏图标的宽度
  final double widthItemImage;

  /// 标题栏图标的高度
  final double heightItemImage;

  FResTitleBar({
    this.backgroundColor = Colors.blue,
    Brightness brightness,
    Color textColor,
    this.imageBack,
    this.height = 45,
    this.textSize = 16,
    this.textSizeSub = 13,
    this.minWidthItem = 40,
    this.widthItemImage = 20,
    this.heightItemImage = 20,
  })  : assert(backgroundColor != null),
        this.brightness =
            brightness ?? ThemeData.estimateBrightnessForColor(backgroundColor),
        this.textColor = textColor ??
            (ThemeData.estimateBrightnessForColor(backgroundColor) ==
                    Brightness.dark
                ? Colors.white
                : FRes.colors().textGrayL);
}
