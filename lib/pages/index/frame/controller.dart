import 'package:get/get.dart';
import 'package:pinker/pages/index/index.dart';

class FrameController extends GetxController {
  final indexController = Get.put(IndexController());

  /// 去登陆页面按钮
  void handleGoSignInPage() {
    indexController.isShow.value = true;
    // await Future.delayed(const Duration(milliseconds: 100));
    Get.toNamed(indexController.pages[1], id: 1);
  }

  /// 去注册页面按钮
  void handleGoSignUpPage() {
    indexController.isShow.value = true;
    Get.toNamed(indexController.pages[2], id: 1);
  }

  @override
  void dispose() {
    indexController.dispose();
    super.dispose();
  }
}
