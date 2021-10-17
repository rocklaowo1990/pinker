import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';

/// 按钮封装
Widget buttonWidget({
  /// 按钮的背景色
  Color? background,

  /// 按钮的点击事件
  required VoidCallback onPressed,

  /// 文字颜色
  Color? textColor,

  /// 按钮文本
  required String text,

  /// 按钮高度
  double? height,

  /// 按钮宽度
  double? width,

  /// 文字对齐方式
  AlignmentGeometry? alignment,

  /// padding
  EdgeInsetsGeometry? padding,
}) {
  return SizedBox(
    /// 宽度不填的话，默认是无无限宽
    width: width ?? double.infinity,

    /// 高度默认是24
    height: height ?? 8.h + 10.h + 10.h,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        /// 对其方式，默认居中对齐
        alignment: alignment ?? Alignment.center,

        textStyle: MaterialStateProperty.all(
          const TextStyle(fontWeight: FontWeight.normal),
        ),

        /// 按钮圆角
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(186.5.w))),

        /// 清空按钮的padding
        padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),

        /// 按钮背景色，默认主色
        backgroundColor:
            MaterialStateProperty.all(background ?? AppColors.mainColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          /// 文字默认白色
          color: textColor ?? AppColors.mainText,
          fontSize: 8.sp,
        ),
      ),
    ),
  );
}
