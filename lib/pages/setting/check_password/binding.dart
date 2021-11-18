import 'package:get/get.dart';
import 'package:pinker/pages/setting/check_password/library.dart';

class CheckPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckPasswordController>(() => CheckPasswordController());
  }
}
