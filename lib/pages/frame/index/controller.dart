import 'package:get/get.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/routes/app_pages.dart';

class IndexController extends GetxController {
  final frameController = Get.put(FrameController());

  /// 去登陆页面按钮
  void handleGoSignInPage() {
    frameController.state.pageIndex++;
    Get.toNamed(AppRoutes.login, id: 1);
  }

  /// 去注册页面按钮
  void handleGoSignUpPage() {
    frameController.state.pageIndex++;
    Get.toNamed(AppRoutes.register, id: 1);
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
