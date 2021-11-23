import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    AppBar appBar = getAppBar(
      getSpan(Lang.setTitle.tr, fontSize: 17),
      backgroundColor: AppColors.secondBacground,
      lineColor: AppColors.line,
    );
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    /// 语言
    Widget langList = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_about.svg'),
      title: Lang.setLang.tr,
      secondTitle: Obx(() => getSpan(
          controller.state.language == const Locale('zh', 'CN')
              ? Lang.setLangValueCN.tr
              : Lang.setLangValueEN.tr,
          color: AppColors.secondIcon)),
      onPressed: controller.handleGoLanguage,
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
      radius: const BorderRadius.all(Radius.zero),
      background: AppColors.secondBacground,
      padding: EdgeInsets.all(9.w),
    );

    /// 用户名
    Widget setUserName = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_user_name.svg'),
      title: '用户名',
      secondTitle: Obx(() => getSpan(
            controller.state.userName,
            color: AppColors.secondIcon,
          )),
      onPressed: controller.handleSetUserName,
    );

    /// 手机
    Widget setUserPhone = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_phone.svg'),
      title: '手机',
      secondTitle: Obx(() => getSpan(
            controller.state.phone == '点击添加' || controller.state.phone.isEmpty
                ? '点击添加'
                : '尾号' + getLastTwo(controller.state.phone),
            color: AppColors.secondIcon,
          )),
      onPressed: controller.handleSetPhone,
    );

    /// 电子邮件
    Widget setUserEmail = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_email.svg'),
      title: '电子邮箱',
      secondTitle: Obx(() => getSpan(
            controller.state.email == '点击添加' || controller.state.email.isEmpty
                ? '点击添加'
                : '尾号' + getEmailHide(controller.state.email),
            color: AppColors.secondIcon,
          )),
      onPressed: controller.handleSetEmail,
    );

    /// 修改密码
    Widget setPassword = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_password.svg'),
      title: '密码',
      secondTitle: getSpan(
        '点击修改',
        color: AppColors.secondIcon,
      ),
      onPressed: controller.handleSetPassword,
    );

    /// 已屏蔽列表
    Widget blockCount = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_shield_list.svg'),
      title: '已屏蔽列表',
      secondTitle: Obx(() => getSpan(
            '${controller.state.blockCount}',
            color: AppColors.secondIcon,
          )),
      onPressed: controller.handleBlockList,
    );

    /// 已隐藏列表
    Widget hiddenCount = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_hide_list.svg'),
      title: '已隐藏列表',
      secondTitle: Obx(() => getSpan(
            '${controller.state.hiddenCount}',
            color: AppColors.secondIcon,
          )),
      onPressed: controller.handleHiddenList,
    );

    /// 水印设置
    Widget setGroup = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_watermark.svg'),
      title: '订阅组设置',
      secondTitle: getSpan(''),
      onPressed: controller.handleGoLanguage,
    );

    /// 水印设置
    Widget setWatermark = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_watermark.svg'),
      title: '水印设置',
      secondTitle: getSpan(''),
      onPressed: controller.handleGoLanguage,
    );

    /// 注销账号
    Widget logout = getButtonList(
      icon: SvgPicture.asset('assets/svg/set_logout.svg'),
      title: '注销账号',
      secondTitle: getSpan(''),
      onPressed: controller.handleGoLanguage,
    );
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////

    /// 登陆后的设置页面
    Widget bodyToken = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(9.w),
          child: getSpan(
            '账号',
            fontSize: 17,
            color: AppColors.mainColor,
          ),
        ),
        setUserName,
        SizedBox(height: 1.h),
        setUserPhone,
        SizedBox(height: 1.h),
        setUserEmail,
        SizedBox(height: 1.h),
        setPassword,
        Padding(
          padding: EdgeInsets.all(9.w),
          child: getSpan(
            '隐私',
            fontSize: 17,
            color: AppColors.mainColor,
          ),
        ),
        blockCount,
        SizedBox(height: 1.h),
        hiddenCount,
        Padding(
          padding: EdgeInsets.all(9.w),
          child: getSpan(
            '设置',
            fontSize: 17,
            color: AppColors.mainColor,
          ),
        ),
        setGroup,
        SizedBox(height: 1.h),
        setWatermark,
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
