import 'package:get/get.dart';
import 'package:pinker/pages/frame/login/index.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
