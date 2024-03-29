import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/setting/set_language/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget sureBox = Obx(
      () => controller.state.language == null ||
              controller.state.language ==
                  controller.settingController.state.language
          ? const SizedBox()
          : getButton(
              background: Colors.transparent,
              child: SizedBox(
                child: Center(
                  child: getButtonSheet(
                    child: getSpan(Lang.sure.tr),
                  ),
                ),
              ),
              onPressed: controller.handleSure,
            ),
    );

    /// appBar
    AppBar appBar = getAppBar(
      getSpanTitle(Lang.langTitle.tr),
      // lineColor: AppColors.line,
      backgroundColor: AppColors.secondBacground,
      actions: [
        sureBox,
        const SizedBox(width: 16),
      ],
    );

    /// 中文列表
    Widget cnList = getButtonList(
      onPressed: controller.handleToLanguageCN,
      title: Lang.setLangValueCN.tr,
      iconRight: Obx(
        () => getCheckIcon(
          isChooise: controller.state.language == const Locale('zh', 'CN')
              ? true
              : false,
        ),
      ),
    );

    /// 英文列表
    Widget enList = getButtonList(
      onPressed: controller.handleToLanguageUS,
      title: Lang.setLangValueEN.tr,
      iconRight: Obx(
        () => getCheckIcon(
          isChooise: controller.state.language == const Locale('en', 'US')
              ? true
              : false,
        ),
      ),
    );

    /// body
    Widget body = ListView(
      children: [
        const SizedBox(height: 4),
        cnList,
        const SizedBox(height: 1),
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
