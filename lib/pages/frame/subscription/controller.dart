import 'package:get/get.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/verify/library.dart';
import 'package:pinker/routes/app_pages.dart';

class SubscriptionController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.put(FrameController());

  /// 状态管理
  final VerifyState state = VerifyState();

  void handleNext() {
    Get.offAllNamed(AppRoutes.application);
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
