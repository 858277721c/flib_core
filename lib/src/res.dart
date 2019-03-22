import 'package:flutter/material.dart';

class FRes {
  static FRes _instance;

  FResColors _colors;
  FResDimens _dimens;

  FRes._internal() {
    _colors = FResColors();
    _dimens = FResDimens();
  }

  static FRes getInstance() {
    if (_instance == null) {
      _instance = FRes._internal();
    }
    return _instance;
  }

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
    //---------- titleBar ----------
    Color bgTitleBar,
    Color textTitleBar,
  })  : this.textTabNormal = textTabNormal ?? textGrayS,
        this.textTabSelected = textTabSelected ?? mainColor,
        //---------- titleBar ----------
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

  /// 输入框边框粗细
  final double widthTextFieldBorder;

  /// 圆角半径（大）
  final double cornerRadiusL;

  /// 圆角半径
  final double cornerRadius;

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
    this.heightButton = 36,
    this.heightTextField = 40,
    this.widthDivider = 0.5,
    this.widthTextFieldBorder = 0.5,
    this.cornerRadiusL = 18,
    this.cornerRadius = 5,
    //---------- titleBar ----------
    this.heightTitleBar = 45,
    this.textTitleBar = 16,
    this.textTitleBarSub = 13,
    this.minWidthTitleBarItem = 40,
    this.widthTitleBarItemImage = 20,
    this.heightTitleBarItemImage = 20,
  });
}
