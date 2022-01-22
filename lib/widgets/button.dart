import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/icons.dart';

/// 按钮封装
/// 基本上所有的按钮都可以用到
/// 这个按钮是全局的，任何按钮都可以调用该方法
Widget getButton({
  /// 按钮的背景色
  Color background = AppColors.mainColor,

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
  BorderRadiusGeometry? borderRadius,

  /// 子组件对齐方式
  AlignmentGeometry alignment = Alignment.center,

  /// padding
  EdgeInsetsGeometry padding = EdgeInsets.zero,

  /// 边框
  BorderSide? borderSide,
}) {
  MaterialStateProperty<Size?>? fixedSize;

  if (width != null && height != null) {
    fixedSize = MaterialStateProperty.all(Size(width, height));
  } else if (width != null) {
    fixedSize = MaterialStateProperty.all(Size.fromWidth(width));
  } else if (height != null) {
    fixedSize = MaterialStateProperty.all(Size.fromHeight(height));
  }

  return TextButton(
    clipBehavior: Clip.none,
    onPressed: onPressed,
    style: ButtonStyle(
      /// 对其方式，默认居中对齐
      alignment: alignment,

      fixedSize: fixedSize,
      minimumSize: MaterialStateProperty.all(Size.zero),

      tapTargetSize: MaterialTapTargetSize.shrinkWrap,

      /// 按钮文字样式
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontWeight: FontWeight.normal),
      ),

      overlayColor: MaterialStateProperty.all(overlayColor),

      /// 按钮圆角
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(Get.width),
        ),
      ),

      side: borderSide == null ? null : MaterialStateProperty.all(borderSide),

      /// 清空按钮的padding
      padding: MaterialStateProperty.all(padding),

      /// 按钮背景色，默认主色
      backgroundColor: MaterialStateProperty.all(background),
    ),
    child: child,
  );
}

Widget getButtonMain({
  required Widget child,
  VoidCallback? onPressed,
  Color background = AppColors.mainColor,
}) {
  return getButton(
    width: Get.width,
    height: 40.h,
    child: child,
    onPressed: onPressed,
    background: background,
  );
}

Widget getButtonTransparent({
  required Widget child,
  VoidCallback? onPressed,
  double? height,
  double? width,
}) {
  return getButton(
    child: child,
    background: Colors.transparent,
    overlayColor: Colors.transparent,
    onPressed: onPressed,
    width: width,
    height: height,
  );
}

Widget getButtonSheet({
  required Widget child,
  VoidCallback? onPressed,
  Color background = AppColors.mainColor,
}) {
  return getButton(
    child: child,
    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
    onPressed: onPressed,
    background: background,
  );
}

Widget getButtonSheetOutline({
  required Widget child,
  VoidCallback? onPressed,
}) {
  return getButton(
    child: child,
    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
    onPressed: onPressed,
    background: Colors.transparent,
    borderSide: BorderSide(width: 1.w, color: AppColors.mainColor),
  );
}

Widget getBackButton({
  VoidCallback? onPressed,
}) {
  return getButton(
    child: getBackIcon(),
    background: Colors.transparent,
    width: 60.w,
    height: 60.w,
    onPressed: onPressed ??
        () {
          Get.back();
        },
  );
}

Widget getSettingButton({
  VoidCallback? onPressed,
}) {
  return getButton(
    child: getSettingIcon(),
    width: 60.w,
    height: 60.w,
    onPressed: onPressed,
    background: Colors.transparent,
  );
}

Widget getSuerButton({
  VoidCallback? onPressed,
}) {
  return getButton(
    child: const Icon(
      Icons.done,
      color: AppColors.mainColor,
    ),
    onPressed: onPressed,
    background: Colors.transparent,
    width: 60.w,
    height: 60.w,
  );
}

Widget getCloseButton({
  VoidCallback? onPressed,
}) {
  return getButton(
    child: const Icon(
      Icons.close,
      color: AppColors.mainColor,
    ),
    onPressed: onPressed,
    background: Colors.transparent,
    width: 60.w,
    height: 60.w,
  );
}
