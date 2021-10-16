import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  /// 主色
  static const Color main = Color(0xff0c7dff);

  /// 白色
  static const Color white = Color(0xffffffff);

  /// 输入框颜色
  static const Color inputFiled = Color(0xff20232a);

  /// 输入框hint提示文本或输入框右侧按钮颜色
  static const Color inputHint = Color(0xff94a3b2);

  /// 暗色文本 7d8998
  static const Color darkText = Color(0xff7d8998);

  /// 深灰背景
  static const Color backgroundDark = Color(0xff262932);

  /// 浅灰背景
  static const Color backgroundLight = Color(0xff454a5a);

  /// 按钮禁用状态背景
  static const Color buttonDisable = Color(0x50919aab);

  /// 文字渐变色
  static Shader linearGradientText = const LinearGradient(
    colors: <Color>[
      Color(0xffffffff),
      Color(0x4cffffff),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).createShader(Rect.fromLTWH(0.w, 147.h, 0.w, 40.h));

  /// 背景渐变色
  static const LinearGradient linearGradientContainer = LinearGradient(
    colors: [
      Color(0xff454a5a),
      Color(0xff2e313c),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
