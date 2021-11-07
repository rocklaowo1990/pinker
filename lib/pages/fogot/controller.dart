import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/fogot/library.dart';

class ForgotController {
  /// 状态控制器
  final ForgotState state = ForgotState();

  /// 输入框控制器
  final TextEditingController textController = TextEditingController();

  /// 焦点控制器
  final FocusNode focusNode = FocusNode();

  void handleNext() {}

  void handleBack() {
    Get.back();
  }

  void init() {
    textController.addListener(() {
      if (textController.text.length < 7) {
        state.isDissable = true;
      } else {
        state.isDissable = false;
      }
    });
  }
}
