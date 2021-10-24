import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/colors.dart';

/// 文本封装
/// 传入text size color
Widget getSpan(String? text,
    {double? size,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign}) {
  return Text(
    text ?? '',
    textAlign: textAlign,
    style: TextStyle(
      fontSize: size ?? 8.sp,
      color: color ?? AppColors.mainText,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: TextDecoration.none,
    ),
  );
}
