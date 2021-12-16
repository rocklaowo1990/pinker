import 'dart:ui';

import 'package:get/get.dart';

class LanguageState {
  /// 语言
  final Rx<Locale> _language =
      Get.locale == null ? const Locale('zh', 'CN').obs : Get.locale!.obs;
  set language(value) => _language.value = value;
  Locale? get language => _language.value;

  /// 发送验证码的时间
  final RxInt sendTimeRx = 0.obs;
  set sendTime(int value) => sendTimeRx.value = value;
  int get sendTime => sendTimeRx.value;
}
