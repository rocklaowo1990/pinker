import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar 左侧的返回按钮
    Widget buttonBox = getButton(
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 9.w,
        color: AppColors.mainIcon,
      ),
      onPressed: controller.handleGoSignBeforePage,
      background: Colors.transparent,
    );

    /// appBar
    AppBar appBar = getAppBar(
      leading: buttonBox,
      title: getSpan(Lang.setTitle.tr, size: 10.sp),
      backgroundColor: AppColors.secondBacground,
      elevation: 0.5.h,
    );

    /// 语言
    Widget langList = getList(
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

    /// body
    Widget body = ListView(
      children: [
        SizedBox(height: 4.h),
        langList,
      ],
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
