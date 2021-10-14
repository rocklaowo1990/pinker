import 'package:get/get.dart';
import 'package:pinker/pages/index/sign_up/controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
