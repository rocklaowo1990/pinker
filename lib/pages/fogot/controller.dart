import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/fogot/index/library.dart';

import 'package:pinker/pages/fogot/library.dart';

class ForgotController {
  /// 状态控制器
  final ForgotState state = ForgotState();

  /// 页面控制器
  final PageController pageController = PageController();

  void handleNext() {
    print(state.isDissable);
  }

  void handleBack() {
    Get.back();
  }

  void init() {
    state.pageCount.add(ForgotIndexView());
  }
}
