import 'package:flutter/material.dart';

class AppColors {
  /// 主色
  static const Color mainColor = Color(0xff0c7dff);

  /// 主要Icon
  static const Color mainIcon = Color(0xffffffff);

  /// 次要Icon
  static const Color secondIcon = Color(0xff949cbd);

  /// 半透明Icon
  static const Color thirdIcon = Color(0x50949cbd);

  /// 分割线
  static const Color line = Color(0x20949cbd);

  /// 主要文本
  static const Color mainText = Color(0xffffffff);

  /// 次要文本
  static const Color secondText = Color(0xff7d8998);

  /// 金色文字
  static const Color thirdText = Color(0xfffcc82b);

  /// 输入框颜色
  static const Color inputFiled = Color(0xff20232a);

  /// 日期选择器背景
  static const Color dateBox = Color(0xff949cbd);

  /// 输入框提示文本 输入框右侧按钮
  static const Color inputHint = Color(0xff94a3b2);

  /// 主要背景，一般用于页面背景
  static const Color mainBacground = Color(0xff262932);

  /// 主要背景的半透明状态
  static const Color mainBacground50 = Color(0xaa262932);

  /// 次要背景，和主要背景拉开层次
  static const Color secondBacground = Color(0xff2e313c);

  /// 按钮禁用状态背景
  static const Color buttonDisable = Color(0x50919aab);

  /// 错误颜色
  static const Color errro = Color(0xfff92770);

  /// 订阅分组头像背景色
  static const Color groupAvatarBackground = Color(0xffFFD730);

  /// 文字渐变色
  // static Shader linearGradientText = const LinearGradient(
  //   colors: <Color>[
  //     Color(0xffffffff),
  //     Color(0x4cffffff),
  //   ],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // ).createShader(Rect.fromLTWH(0.w, 147.h, 0.w, 40.h));

  /// 背景渐变色
  static const LinearGradient groupBackground = LinearGradient(
    colors: [
      Color(0xff9677f8),
      Color(0xff4a30c4),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
