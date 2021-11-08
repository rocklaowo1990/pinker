import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/fogot/index/library.dart';

import 'package:pinker/pages/fogot/library.dart';

class ForgotController extends GetxController {
  /// 状态控制器
  final ForgotState state = ForgotState();

  /// 页面控制器
  final PageController pageController = PageController();

  void handleNext() {
    state.pageCount.add(ForgotIndexView());
    print(state.pageCount);
  }

  void handleBack() {
    Get.back();
  }

  @override
  void onInit() async {
    super.onInit();
    state.pageCount.add(ForgotIndexView());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
