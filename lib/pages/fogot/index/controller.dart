import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/fogot/index/library.dart';
import 'package:pinker/pages/fogot/library.dart';

class ForgotIndexController extends GetxController {
  /// 文本控制器
  final TextEditingController textController = TextEditingController();

  /// 焦点控制器
  final FocusNode focusNode = FocusNode();

  /// 状态控制器
  final ForgotIndexState state = ForgotIndexState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  @override
  void onInit() {
    super.onInit();
    textController.addListener(() {
      if (textController.text.length < 7) {
        forgotController.state.isDissable = true;
      } else {
        forgotController.state.isDissable = false;
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    // forgotController.dispose();
    super.onClose();
  }
}
