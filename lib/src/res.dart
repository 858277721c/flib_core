import 'package:flutter/material.dart';

class FRes {
  static FRes _instance;

  FRes._internal() {}

  static FRes getInstance() {
    if (_instance == null) {
      _instance = new FRes._internal();
    }
    return _instance;
  }

  FResColors _colors = new FResColors();
  FResDimens _dimens = new FResDimens();

  void init({FResColors colors, FResDimens dimens}) {
    if (colors != null) {
      _colors = colors;
    }
    if (dimens != null) {
      _dimens = dimens;
    }
  }

  static FResColors colors() {
    return getInstance()._colors;
  }

  static FResDimens dimens() {
    return getInstance()._dimens;
  }
}

class FResColors {
  /// 主题色
  final Color mainColor;

  /// 主题色（按下状态）
  final Color mainColorPressed;

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

  //---------- titleBar ----------

  /// 标题栏背景色
  final Color bgTitleBar;

  /// 标题栏文字颜色
  final Color textTitleBar;

  FResColors({
    this.mainColor,
    Color mainColorPressed,
    Color bgPage,
    Color textGrayL,
    Color textGrayM,
    Color textGrayS,
    Color textHint,
    Color textTabNormal,
    Color textTabSelected,
    Color shadowText,
    Color divider,
    //---------- titleBar ----------
    Color bgTitleBar,
    Color textTitleBar,
  })  : assert(mainColor != null),
        this.mainColorPressed = mainColorPressed ?? mainColor,
        this.bgPage = bgPage ?? Color(0xFFF7F7F7),
        this.textGrayL = textGrayL ?? Color(0xFF333333),
        this.textGrayM = textGrayM ?? Color(0xFF666666),
        this.textGrayS = textGrayS ?? Color(0xFF999999),
        this.textHint = textHint ?? Color(0xFFCBCBCB),
        this.textTabNormal = textTabNormal ?? Color(0xFF999999),
        this.textTabSelected = textTabSelected ?? mainColor,
        this.shadowText = shadowText ?? Color(0xFF333333),
        this.divider = divider ?? Color(0xFFE7E7F1),
        this.bgTitleBar = bgTitleBar ?? mainColor,
        this.textTitleBar = textTitleBar ?? Colors.white;
}

class FResDimens {
  /// 通用按钮高度
  final double heightButton;

  /// 通用输入框高度
  final double heightTextField;

  /// 边框粗细
  final double widthDivider;

  //---------- titleBar ----------

  /// 标题栏高度
  final double heightTitleBar;

  /// 标题栏文字大小
  final double textTitleBar;

  /// 标题栏小一号文字大小
  final double textTitleBarSub;

  /// 标题栏item的最小宽度
  final double minWidthTitleBarItem;

  /// 标题栏图标的宽度
  final double widthTitleBarItemImage;

  /// 标题栏图标的高度
  final double heightTitleBarItemImage;

  FResDimens({
    this.heightButton = 40,
    this.heightTextField = 40,
    this.widthDivider = 0.5,
    //---------- titleBar ----------
    this.heightTitleBar = 45,
    this.textTitleBar = 16,
    this.textTitleBarSub = 13,
    this.minWidthTitleBarItem = 40,
    this.widthTitleBarItemImage = 20,
    this.heightTitleBarItemImage = 20,
  });
}
