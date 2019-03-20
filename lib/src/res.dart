import 'package:flutter/painting.dart';

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
        this.divider = divider ?? Color(0xFFE7E7F1);
}

class FResDimens {
  /// 通用按钮高度
  final double heightButton;

  /// 通用输入框高度
  final double heightTextField;

  /// 边框粗细
  final double widthDivider;

  FResDimens({
    this.heightButton = 40,
    this.heightTextField = 40,
    this.widthDivider = 0.5,
  });
}
