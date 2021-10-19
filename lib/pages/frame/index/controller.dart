import 'package:get/get.dart';
import 'package:pinker/pages/frame/frame.dart';

class IndexController extends GetxController {
  final frameController = Get.put(FrameController());

  /// 去登陆页面按钮
  void handleGoSignInPage() {
    frameController.isShow.value = true;

    Get.toNamed(frameController.pages[1], id: 1);
  }

  /// 去注册页面按钮
  void handleGoSignUpPage() {
    frameController.isShow.value = true;
    Get.toNamed(frameController.pages[2], id: 1);
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
