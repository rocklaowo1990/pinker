import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 功能按钮列表
Widget getButtonList({
  Widget? icon,
  String? title,
  Widget? secondTitle,
  Widget? iconRight,
  VoidCallback? onPressed,
  double? height,
  EdgeInsetsGeometry? padding,
}) {
  /// 左边初始化
  Widget left = Row(
    children: [
      icon ?? const SizedBox(),
      SizedBox(width: 8.w),
      getSpan(title),
    ],
  );

  /// 右边初始化
  Widget right = Row(
    children: [
      secondTitle ?? const SizedBox(),
      SizedBox(width: 4.w),
      SvgPicture.asset(
        'assets/svg/icon_right.svg',
        height: 7.h,
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
    right = SvgPicture.asset('assets/svg/icon_right.svg', height: 10.h);
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
    borderRadius: BorderRadius.zero,
    background: AppColors.secondBacground,
    height: height,
    padding: padding ?? EdgeInsets.all(9.w),
    onPressed: onPressed,
  );
}

/// 用户头像
/// 用户昵称
/// 用户名的组合
/// 这里单独封装出来是为了其他地方可用
Widget getUserAvatar(
  String avatar,
  String nickName,
  String userName, {
  VoidCallback? onPressed,
}) {
  /// 头像
  Widget avatarBox = Container(
    width: 26.w,
    height: 26.w,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.thirdIcon,
    ),
    child: Center(
      child: avatar.isEmpty || isInclude(avatar, 'user_default_head.png')
          ? SvgPicture.asset(
              'assets/svg/avatar_default.svg',
              width: 32.w,
            )
          : getNetworkImageBox(avatar, shape: BoxShape.circle),
    ),
  );

  /// 用户名称
  Widget userNameBox = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getSpan(nickName, color: AppColors.mainText),
      SizedBox(height: 2.h),
      SizedBox(
        width: double.infinity,
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
  return getButton(
    onPressed: onPressed,
    overlayColor: Colors.transparent,
    background: Colors.transparent,
    child: Row(
      children: [
        avatarBox,
        SizedBox(width: 8.w),
        Expanded(child: userNameBox),
      ],
    ),
  );
}

/// 用户列表-无简介
Widget getUserList(
  String avatar,
  String userName,
  String nickName, {
  VoidCallback? buttonPressed,
  VoidCallback? avatarPressed,
  String? buttonText,
  Widget? button,
  EdgeInsetsGeometry? padding,
  BoxBorder? border,
  String? intro,
  Color? color,
}) {
  /// 左侧组合
  Widget leftBox = getUserAvatar(
    avatar,
    nickName,
    userName,
    onPressed: avatarPressed,
  );

  /// 按钮
  Widget buttonBox = getButton(
    child: getSpan(buttonText ?? '订阅'),
    onPressed: buttonPressed,
    width: 40.w,
    height: 16.w,
    borderSide: BorderSide(width: 0.5.w, color: AppColors.mainColor),
    background: Colors.transparent,
  );

  Widget body = Row(children: [
    Expanded(child: leftBox),
    button ?? buttonBox,
  ]);

  ///
  return Container(
    width: double.infinity,
    padding: padding ?? EdgeInsets.all(8.w),
    decoration: BoxDecoration(
      color: color,
      border: border ??
          Border(top: BorderSide(width: 0.5.w, color: AppColors.line)),
    ),
    child: intro != null && intro.isNotEmpty
        ? Column(
            children: [
              body,
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: getSpan(intro, color: AppColors.secondText),
              ),
            ],
          )
        : body,
  );
}
