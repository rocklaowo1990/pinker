import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/index.dart';
import 'package:pinker/widgets/widgets.dart';

class LanguageController extends GetxController {
  final settingController = Get.put(SettingController());

  /// 初始化
  // @override
  // void onInit() {}

  /// 返回
  void handleGoSignBeforePage() {
    Get.back();
  }

  void handleToLanguageCN() {
    Locale zhCN = const Locale('zh', 'CN');
    if (Get.locale == zhCN) return;
    Get.updateLocale(zhCN);
    settingController.language.value = zhCN;
    getSnackTop(
      msg: Lang.langMsg.tr,
      iconData: Icons.check_circle,
      iconColor: Colors.green,
    );
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   Get.back();
    // });
  }

  void handleToLanguageUS() {
    Locale enUS = const Locale('en', 'US');
    if (Get.locale == enUS) return;
    Get.updateLocale(enUS);
    settingController.language.value = enUS;
    getSnackTop(
      msg: Lang.langMsg.tr,
      iconData: Icons.check_circle,
      iconColor: Colors.green,
    );
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   Get.back();
    // });
  }

  /// 页面销毁
  @override
  void dispose() {
    settingController.dispose();
    super.dispose();
  }
}
