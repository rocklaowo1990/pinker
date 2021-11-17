import 'dart:ui';

import 'package:get/get.dart';

class LanguageState {
  /// 语言
  final Rx<Locale?> _language = Get.locale.obs;
  set language(value) => _language.value = value;
  Locale? get language => _language.value;

  /// 用户名
  final RxString _userName = ''.obs;
  set userName(String value) => _userName.value = value;
  String get userName => _userName.value;

  /// 手机
  final RxString _phone = ''.obs;
  set phone(String value) => _phone.value = value;
  String get phone => _phone.value;

  /// Email
  final RxString _email = ''.obs;
  set email(String value) => _email.value = value;
  String get email => _email.value;

  /// 屏蔽列表
  final RxInt _blockCount = 0.obs;
  set blockCount(int value) => _blockCount.value = value;
  int get blockCount => _blockCount.value;

  /// 屏蔽列表
  final RxInt _hiddenCount = 0.obs;
  set hiddenCount(int value) => _hiddenCount.value = value;
  int get hiddenCount => _hiddenCount.value;
}
