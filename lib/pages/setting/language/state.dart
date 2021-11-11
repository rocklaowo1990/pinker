import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageState {
  /// 语言
  final Rx<Locale?> _language = Get.locale.obs;
  set language(value) => _language.value = value;
  Locale? get language => _language.value;
}
