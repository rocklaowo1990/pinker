import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/library.dart';
import 'package:pinker/widgets/widgets.dart';

class LanguageController extends GetxController {
  final settingController = Get.put(SettingController());

  /// 返回
  void handleGoSignBeforePage() {
    Get.back();
  }

  void handleToLanguageCN() async {
    Locale zhCN = const Locale('zh', 'CN');
    if (Get.locale == zhCN) return;
    Get.updateLocale(zhCN);
    settingController.state.language = zhCN;
    getSnackTop(
      Lang.langMsg.tr,
      iconData: Icons.check_circle,
      iconColor: Colors.green,
    );
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.back();
  }

  void handleToLanguageUS() async {
    Locale enUS = const Locale('en', 'US');
    if (Get.locale == enUS) return;
    Get.updateLocale(enUS);
    settingController.state.language = enUS;
    getSnackTop(
      Lang.langMsg.tr,
      iconData: Icons.check_circle,
      iconColor: Colors.green,
    );
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.back();
  }

  /// 页面销毁
  @override
  void dispose() {
    settingController.dispose();
    super.dispose();
  }
}
