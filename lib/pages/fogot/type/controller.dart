import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/type/library.dart';
import 'package:pinker/pages/fogot/verify/library.dart';

class ForgotTypeController extends GetxController {
  /// 状态控制器
  final ForgotTypeState state = ForgotTypeState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  /// 下一步
  void handleNext() async {
    forgotController.state.pageCount.add(const ForgotVerifyView());
    forgotController.state.pageIndex++;

    forgotController.pageController.animateToPage(
      forgotController.state.pageCount.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void handlePhoneType() {
    forgotController.state.verifyType = 1;
  }

  void handleEmailType() {
    forgotController.state.verifyType = 2;
  }
}
