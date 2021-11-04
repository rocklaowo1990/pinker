import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/global.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/setting/library.dart';

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
    );

    /// 语言
    Widget langList = getButtonList(
      title: Lang.setLang.tr,
      secondTitle: Obx(
        () => getSpan(
            controller.state.language == const Locale('zh', 'CN')
                ? Lang.setLangValueCN.tr
                : Lang.setLangValueEN.tr,
            color: AppColors.secondIcon),
      ),
      onPressed: controller.handleGoLanguage,
    );

    /// 未登录设置页面
    Widget bodyNoToken = ListView(
      children: [
        SizedBox(height: 4.h),
        langList,
      ],
    );

    Widget signOut = getButton(
      child: getSpan('退出登陆', color: AppColors.errro),
      onPressed: controller.handleSignOut,
      radius: const BorderRadius.all(Radius.zero),
      background: AppColors.secondBacground,
      height: 30.h,
      padding: EdgeInsets.only(
        left: 10.w,
        right: 8.w,
      ),
    );

    /// 登陆后的设置页面
    Widget bodyToken = ListView(
      children: [
        SizedBox(height: 4.h),
        signOut,
      ],
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: Global.token == null ? bodyNoToken : bodyToken,
    );
  }
}
