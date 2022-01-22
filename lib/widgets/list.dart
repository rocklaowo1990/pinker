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
  BorderSide? borderSide,
}) {
  /// 左边初始化
  Widget left = Row(
    children: [
      icon ?? const SizedBox(),
      SizedBox(width: 16.w),
      getSpan(title),
    ],
  );

  /// 右边初始化
  Widget right = Row(
    children: [
      secondTitle ?? const SizedBox(),
      SizedBox(width: 10.w),
      SvgPicture.asset(
        'assets/svg/icon_right.svg',
        width: 12.w,
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
    right = SvgPicture.asset(
      'assets/svg/icon_right.svg',
      width: 12.w,
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
    borderRadius: BorderRadius.zero,
    background: AppColors.secondBacground,
    height: height,
    padding: padding ?? EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.w),
    onPressed: onPressed,
    borderSide: borderSide,
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
    width: 50.w,
    height: 50.w,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.thirdIcon,
    ),
    child: Center(
      child: avatar.isEmpty || isInclude(avatar, 'user_default_head.png')
          ? SvgPicture.asset(
              'assets/svg/avatar_default.svg',
              width: 50.w,
            )
          : getNetworkImageBox(avatar, shape: BoxShape.circle),
    ),
  );

  /// 用户名称
  Widget userNameBox = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getSpan(nickName),
      SizedBox(height: 5.h),
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
    // padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 10.h),
    child: Row(
      children: [
        avatarBox,
        SizedBox(width: 16.w),
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
  Widget buttonBox = getButtonSheetOutline(
    child: getSpan(buttonText ?? '订阅'),
    onPressed: buttonPressed,
  );

  Widget body = Row(children: [
    Expanded(child: leftBox),
    button ?? buttonBox,
  ]);

  ///
  return Container(
    width: double.infinity,
    padding: padding ?? EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
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
                child: getSpan(
                  '个人简介：$intro',
                  color: AppColors.secondText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        : body,
  );
}
