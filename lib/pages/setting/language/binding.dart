import 'package:get/get.dart';
import 'package:pinker/pages/setting/language/controller.dart';

class LanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}
