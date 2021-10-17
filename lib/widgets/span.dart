import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/colors.dart';

/// 文本封装
/// 传入text size color
Widget span({
  required String text,
  double? size,
  Color? color,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size ?? 8.sp,
      color: color ?? AppColors.mainText,
    ),
  );
}
