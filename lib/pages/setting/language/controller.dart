import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/setting/library.dart';

class LanguageController extends GetxController {
  final settingController = Get.put(SettingController());
  final state = LanguageState();

  /// 返回
  void handleGoSignBeforePage() {
    Get.back();
  }

  void handleSure() {
    Get.updateLocale(state.language!);
    settingController.state.language = state.language;
    Get.back();
  }

  void handleToLanguageCN() async {
    Locale zhCN = const Locale('zh', 'CN');
    if (state.language == zhCN) return;
    state.language = zhCN;
  }

  void handleToLanguageUS() async {
    Locale enUS = const Locale('en', 'US');
    if (state.language == enUS) return;
    state.language = enUS;
  }

  /// 页面销毁
  @override
  void dispose() {
    settingController.dispose();
    super.dispose();
  }
}
