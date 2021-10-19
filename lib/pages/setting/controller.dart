import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/routes/app_pages.dart';

class SettingController extends GetxController {
  /// 语言
  Rx<Locale?> language = Get.locale.obs;

  /// 初始化
  // @override
  // void onInit() {}

  /// 返回
  void handleGoSignBeforePage() {
    Get.back();
  }

  /// 去语言选择页面
  void handleGoLanguage() {
    Get.toNamed('${AppRoutes.set}/${AppRoutes.language}');
  }

  /// 页面销毁
  @override
  void dispose() {
    super.dispose();
  }
}
