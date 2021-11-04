import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';

/// 按钮封装
Widget getButton({
  /// 按钮的背景色
  Color? background,

  /// 按钮的背景色
  Color? overlayColor,

  /// 按钮的点击事件
  VoidCallback? onPressed,

  /// 子组件
  required Widget child,

  /// 按钮高度
  double? height,

  /// 按钮宽度
  double? width,

  /// 按钮宽度
  BorderRadiusGeometry? radius,

  /// 子组件对齐方式
  AlignmentGeometry? alignment,

  /// padding
  EdgeInsetsGeometry? padding,

  /// 边框
  BorderSide? side,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        /// 对其方式，默认居中对齐
        alignment: alignment ?? Alignment.center,

        /// 按钮文字样式
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontWeight: FontWeight.normal),
        ),

        overlayColor: MaterialStateProperty.all(overlayColor),

        /// 按钮圆角
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: radius ?? BorderRadius.circular(186.5.w),
          ),
        ),

        side: side == null ? null : MaterialStateProperty.all(side),

        /// 清空按钮的padding
        padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),

        /// 按钮背景色，默认主色
        backgroundColor:
            MaterialStateProperty.all(background ?? AppColors.mainColor),
      ),
      child: child,
    ),
  );
}
