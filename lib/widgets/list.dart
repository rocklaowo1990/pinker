import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getList({
  IconData? icon,
  String? title,
  Widget? secondTitle,
  Widget? iconRight,
  VoidCallback? onPressed,
}) {
  /// 左边初始化
  Widget left = Row(
    children: [
      Icon(icon),
      SizedBox(
        width: 8.w,
      ),
      getSpan(title),
    ],
  );

  /// 右边初始化
  Widget right = Row(
    children: [
      secondTitle ?? const SizedBox(),
      SizedBox(width: 4.w),
      const Icon(
        Icons.navigate_next,
        color: AppColors.secondIcon,
      ),
    ],
  );

  /// 左边没有传入图标的时候
  if (icon == null) {
    left = getSpan(title);
  }

  /// 右边没有传入文字的时候
  if (secondTitle == null) {
    right = const Icon(
      Icons.navigate_next,
      color: AppColors.secondIcon,
    );
  }

  /// 右侧图标如果有传入新的 widge
  if (iconRight != null) {
    right = Row(
      children: [
        secondTitle ?? const SizedBox(),
        SizedBox(width: 4.w),
        iconRight,
      ],
    );
  }

  /// 按钮组合
  Widget textButtonChild = Row(
    children: [
      left,
      const Spacer(),
      right,
    ],
  );

  /// 组合
  return getButton(
    child: textButtonChild,
    radius: 0,
    background: AppColors.secondBacground,
    height: 30.h,
    padding: EdgeInsets.only(
      left: 10.w,
      right: 8.w,
    ),
    onPressed: onPressed,
  );
}
