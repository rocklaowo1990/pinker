import 'package:get/get.dart';
import 'package:pinker/pages/frame/password/controller.dart';

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordController>(() => PasswordController());
  }
}
