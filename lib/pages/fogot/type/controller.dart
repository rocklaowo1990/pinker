import 'package:get/get.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/type/library.dart';

import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotTypeController extends GetxController {
  /// 状态控制器
  final ForgotTypeState state = ForgotTypeState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  /// 下一步
  void handleNext() async {
    getDialog();

    await futureMill(500);
    Get.back();
    forgotController.state.pageIndex++;
    Get.offNamed(AppRoutes.forgotVerify, id: 3);
  }

  void handlePhoneType() {
    forgotController.state.verifyType = 1;
  }

  void handleEmailType() {
    forgotController.state.verifyType = 2;
  }
}
