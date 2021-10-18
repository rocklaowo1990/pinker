import 'package:get/get.dart';
import 'package:pinker/pages/setting/controller.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
