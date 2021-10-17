import 'dart:ui';

import 'package:get/get.dart';

part 'lang_keys.dart';
part "en_us.dart";
part 'zh_cn.dart';

class TranslationService extends Translations {
  static const locale = Locale('zh', 'CN');
  static const fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zh,
        'en_US': en,
      };
}
