import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pinker/values/colors.dart';

/// 文本封装
/// 传入text size color
Widget getSpan(
  String? text, {
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text ?? '请输入文本',
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: overflow,
    softWrap: true,
    style: TextStyle(
      height: 1.1,
      fontSize: fontSize ?? 14.sp,
      color: color ?? AppColors.mainText,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: TextDecoration.none,
    ),
  );
}

Widget getIndexTitle(String text) {
  return getSpan(
    text,
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
  );
}

Widget getTitle(String text) {
  return getSpan(
    text,
    fontSize: 20.sp,
    // fontWeight: FontWeight.w400,
  );
}

Widget getSpanTitle(String text) {
  return getSpan(
    text,
    fontSize: 16.sp,
    // fontWeight: FontWeight.w400,
  );
}

Widget getSpanMain(String text) {
  return getSpan(text, color: AppColors.mainColor);
}

Widget getSpanSecond(String text) {
  return getSpan(text, color: AppColors.secondText);
}
