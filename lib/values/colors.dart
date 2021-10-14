import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  /// 背景渐变色
  static const LinearGradient linearGradientContainer = LinearGradient(
    colors: [
      Color(0xff454a5a),
      Color(0xff2e313c),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// 主色
  static const Color main = Color(0xff0c7dff);

  /// 白色
  static const Color white = Color(0xffffffff);

  /// 暗色文本 7d8998
  static const Color darkText = Color(0xff7d8998);

  /// 文字渐变色
  static Shader linearGradientText = const LinearGradient(colors: <Color>[
    Color(0xffffffff),
    Color(0x4cffffff),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
      .createShader(Rect.fromLTWH(0.w, 147.h, 0.w, 40.h));
}
