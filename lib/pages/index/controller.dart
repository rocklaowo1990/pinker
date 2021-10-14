import 'package:get/get.dart';

class IndexController extends GetxController {
  IndexController();

  /// 登陆按钮
  void handleSignIn() {
    Get.toNamed('/index/signIn');
  }

  /// 注册按钮
  void handleSignUp() {
    Get.toNamed('/index/signUp');
  }
}
