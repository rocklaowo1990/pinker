import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/setting/set_language/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar 右侧的设置按钮
    Widget sureBox = Obx(() => getButton(
          child: controller.state.language == null ||
                  controller.state.language ==
                      controller.settingController.state.language
              ? const SizedBox()
              : const Icon(
                  Icons.done,
                  color: AppColors.mainColor,
                ),
          onPressed: controller.state.language == null ||
                  controller.state.language ==
                      controller.settingController.state.language
              ? null
              : controller.handleSure,
          background: Colors.transparent,
          width: 30.w,
          height: 30.w,
        ));

    /// appBar
    AppBar appBar = getAppBar(
      getSpan(Lang.langTitle.tr, fontSize: 17),
      lineColor: AppColors.line,
      backgroundColor: AppColors.secondBacground,
      actions: [sureBox],
    );

    /// 中文列表
    Widget cnList = getButtonList(
      onPressed: controller.handleToLanguageCN,
      title: Lang.setLangValueCN.tr,
      iconRight: Obx(() => Icon(
            Icons.check_circle,
            size: 9.w,
            color: controller.state.language == const Locale('zh', 'CN')
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
            color: controller.state.language == const Locale('en', 'US')
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
