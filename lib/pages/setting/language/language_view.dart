import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/language/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan(Lang.langTitle.tr, size: 10.sp),
      backgroundColor: AppColors.secondBacground,
      elevation: 0.5.h,
    );

    /// 中文列表
    Widget cnList = getButtonList(
      onPressed: controller.handleToLanguageCN,
      title: Lang.setLangValueCN.tr,
      iconRight: Obx(() => Icon(
            Icons.check_circle,
            size: 9.w,
            color: controller.settingController.state.language ==
                    const Locale('zh', 'CN')
                ? AppColors.mainColor
                : AppColors.thirdIcon,
          )),
    );

    /// 英文列表
    Widget enList = getButtonList(
      onPressed: controller.handleToLanguageUS,
      title: Lang.setLangValueEN.tr,
      iconRight: Obx(() => Icon(
            Icons.check_circle,
            size: 9.w,
            color: controller.settingController.state.language ==
                    const Locale('en', 'US')
                ? AppColors.mainColor
                : AppColors.thirdIcon,
          )),
    );

    /// body
    Widget body = ListView(
      children: [
        SizedBox(height: 4.h),
        cnList,
        SizedBox(height: 0.5.h),
        enList,
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
