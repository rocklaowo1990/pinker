import 'package:get/get.dart';

import 'package:pinker/pages/setting/set_language/library.dart';

class LanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}
