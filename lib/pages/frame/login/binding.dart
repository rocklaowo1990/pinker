import 'package:get/get.dart';
import 'package:pinker/pages/frame/login/library.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
