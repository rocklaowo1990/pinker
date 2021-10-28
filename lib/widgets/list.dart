import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 功能按钮列表
Widget getButtonList({
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
    radius: BorderRadius.zero,
    background: AppColors.secondBacground,
    height: 30.h,
    padding: EdgeInsets.only(
      left: 10.w,
      right: 8.w,
    ),
    onPressed: onPressed,
  );
}

/// 用户列表
Widget getUserList({
  String? avatar,
  String? userName,
  String? nickName,
  VoidCallback? onPressed,
}) {
  /// 头像
  Widget avatarBox = Container(
    width: 32.w,
    height: 32.w,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.secondBacground,
    ),
    child: Center(
      child: avatar == null || avatar == ''
          ? Icon(
              Icons.account_circle,
              size: 32.w,
              color: AppColors.mainBacground,
            )
          : CircleAvatar(
              radius: 32.w,
              backgroundImage: NetworkImage(avatar),
            ),
    ),
  );

  /// 用户名称
  Widget userNameBox = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getSpan(nickName, color: AppColors.mainText, size: 9.sp),
      SizedBox(
        width: 60.w,
        child: getSpan(
          userName,
          color: AppColors.secondText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );

  /// 左侧组合
  Widget leftBox = Row(
    children: [
      avatarBox,
      SizedBox(width: 8.w),
      userNameBox,
    ],
  );

  /// 按钮
  Widget buttonBox = getButton(
    child: getSpan('订阅'),
    onPressed: onPressed,
    width: 40.w,
    height: 16.w,
    side: BorderSide(width: 0.5.w, color: AppColors.mainColor),
    background: Colors.transparent,
  );

  /// 左边初始化
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
      width: 0.5.w,
      color: AppColors.secondBacground,
    ))),
    child: Row(
      children: [
        Expanded(child: leftBox),
        buttonBox,
      ],
    ),
  );
}
