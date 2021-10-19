import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/setting/index.dart';

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
    Get.updateLocale(zhCN);
    settingController.language.value = zhCN;
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.back();
    });
  }

  void handleToLanguageUS() {
    Locale enUS = const Locale('en', 'US');
    Get.updateLocale(enUS);
    settingController.language.value = enUS;
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.back();
    });
  }

  /// 页面销毁
  @override
  void dispose() {
    settingController.dispose();
    super.dispose();
  }
}
