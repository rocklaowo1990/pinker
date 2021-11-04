import 'package:flutter/material.dart';

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
    style: TextStyle(
      fontSize: fontSize ?? 15.0,
      color: color ?? AppColors.mainText,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: TextDecoration.none,
    ),
  );
}
