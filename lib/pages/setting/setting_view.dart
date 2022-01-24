import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getDefaultBar(Lang.setTitle.tr);
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    /// 语言
    Widget langList = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_about.svg',
        height: 20.h,
      ),
      title: Lang.setLang.tr,
      secondTitle: Obx(() => getSpan(
          controller.state.language == const Locale('zh', 'CN')
              ? Lang.setLangValueCN.tr
              : Lang.setLangValueEN.tr,
          color: AppColors.secondIcon)),
      onPressed: controller.handleSetLanguage,
    );
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////

    /// 未登录设置页面
    Widget bodyNoToken = ListView(
      children: [
        SizedBox(height: 4.h),
        langList,
      ],
    );

    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    /// 退出登陆
    Widget signOut = getButton(
      child: getSpan('退出登陆', color: AppColors.errro),
      onPressed: controller.handleSignOut,
      borderRadius: const BorderRadius.all(Radius.zero),
      background: AppColors.secondBacground,
      padding: EdgeInsets.all(16.w),
    );

    /// 用户名
    Widget setUserName = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_user_name.svg',
        height: 20.h,
      ),
      title: '用户名',
      secondTitle: controller.arguments != null
          ? Obx(() => getSpan(
                controller.arguments!.state.userInfo.value.userName,
                color: AppColors.secondIcon,
              ))
          : null,
      onPressed: controller.handleSetUserName,
    );

    /// 手机
    Widget setUserPhone = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_phone.svg',
        height: 20.h,
      ),
      title: '手机',
      secondTitle: controller.arguments != null
          ? Obx(() => getSpan(
                controller.arguments!.state.userInfo.value.phone.isEmpty
                    ? '点击添加'
                    : '尾号' +
                        getLastTwo(
                            controller.arguments!.state.userInfo.value.phone),
                color: AppColors.secondIcon,
              ))
          : null,
      onPressed: controller.handleSetPhone,
    );

    /// 电子邮件
    Widget setUserEmail = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_email.svg',
        height: 20.h,
      ),
      title: '电子邮箱',
      secondTitle: controller.arguments != null
          ? Obx(() => getSpan(
                controller.arguments!.state.userInfo.value.email.isEmpty
                    ? '点击添加'
                    : '尾号' +
                        getEmailHide(
                            controller.arguments!.state.userInfo.value.email),
                color: AppColors.secondIcon,
              ))
          : null,
      onPressed: controller.handleSetEmail,
    );

    /// 修改密码
    Widget setPassword = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_password.svg',
        height: 20.h,
      ),
      title: '密码',
      secondTitle: getSpan(
        '点击修改',
        color: AppColors.secondIcon,
      ),
      onPressed: controller.handleSetPassword,
    );

    /// 已屏蔽列表
    Widget blockCount = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_shield_list.svg',
        height: 20.h,
      ),
      title: '已屏蔽列表',
      secondTitle: controller.arguments != null
          ? Obx(() => getSpan(
                '${controller.arguments!.state.userInfo.value.blockCount}',
                color: AppColors.secondIcon,
              ))
          : null,
      onPressed: controller.handleBlockList,
    );

    /// 已隐藏列表
    Widget hiddenCount = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_hide_list.svg',
        height: 20.h,
      ),
      title: '已隐藏列表',
      secondTitle: controller.arguments != null
          ? Obx(() => getSpan(
                '${controller.arguments!.state.userInfo.value.hiddenCount}',
                color: AppColors.secondIcon,
              ))
          : null,
      onPressed: controller.handleHiddenList,
    );

    /// 订阅组设置
    Widget setGroup = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_watermark.svg',
        height: 20.h,
      ),
      title: '订阅组设置',
      secondTitle: getSpan(''),
      onPressed: controller.handleSetGroup,
    );

    /// 水印设置
    Widget setWatermark = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_watermark.svg',
        height: 20.h,
      ),
      title: '水印设置',
      secondTitle: getSpan(''),
      onPressed: controller.handleSetUserLogo,
    );

    /// 麻将结算系统
    Widget money = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_watermark.svg',
        height: 20.h,
      ),
      title: '麻将结算系统',
      secondTitle: getSpan('内测版', color: AppColors.secondIcon),
      onPressed: controller.handleMoney,
    );

    /// 注销账号
    Widget logout = getButtonList(
      icon: SvgPicture.asset(
        'assets/svg/set_logout.svg',
        height: 20.h,
      ),
      title: '注销账号',
      secondTitle: getSpan(''),
      onPressed: controller.handleDeltetAccount,
    );
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////

    /// 登陆后的设置页面
    Widget bodyToken = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: getSpanMain('账号'),
        ),
        setUserName,
        SizedBox(height: 1.h),
        setUserPhone,
        SizedBox(height: 1.h),
        setUserEmail,
        SizedBox(height: 1.h),
        setPassword,
        Padding(
          padding: EdgeInsets.all(16.w),
          child: getSpanMain('隐私'),
        ),
        blockCount,
        SizedBox(height: 1.h),
        hiddenCount,
        Padding(
          padding: EdgeInsets.all(16.w),
          child: getSpanMain('设置'),
        ),
        setGroup,
        SizedBox(height: 1.h),
        setWatermark,
        SizedBox(height: 1.h),
        money,
        SizedBox(height: 1.h),
        langList,
        SizedBox(height: 1.h),
        logout,
        SizedBox(height: 12.h),
        signOut,
      ],
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: controller.arguments == null ? bodyNoToken : bodyToken,
    );
  }
}
