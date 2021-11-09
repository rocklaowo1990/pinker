import 'package:get/get.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/verify/library.dart';

class ForgotVerifyController extends GetxController {
  /// 状态控制器
  final ForgotVerifyState state = ForgotVerifyState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  /// 下一步
  void handleNext() async {}

  void handlePhoneType() {
    state.verifyType = 1;
    print(state.verifyType);
  }

  void handleEmailType() {
    state.verifyType = 2;
    print(state.verifyType);
  }
}
