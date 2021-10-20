import 'package:get/get.dart';
import 'package:pinker/pages/frame/frame.dart';
import 'package:pinker/routes/app_pages.dart';

class IndexController extends GetxController {
  final frameController = Get.put(FrameController());

  /// 去登陆页面按钮
  void handleGoSignInPage() {
    frameController.isShow.value = true;

    Get.toNamed(AppRoutes.login, id: 1);
  }

  /// 去注册页面按钮
  void handleGoSignUpPage() {
    frameController.isShow.value = true;
    Get.toNamed(AppRoutes.register, id: 1);
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
