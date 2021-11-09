import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/fogot/info/library.dart';
import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/type/library.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotInfoController extends GetxController {
  /// 文本控制器
  final TextEditingController textController = TextEditingController();

  /// 焦点控制器
  final FocusNode focusNode = FocusNode();

  /// 状态控制器
  final ForgotInfoState state = ForgotInfoState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  void handleNext() {
    if (textController.text == forgotController.userInfo.phone ||
        textController.text == forgotController.userInfo.email) {
      textController.text = '';
      forgotController.state.pageCount.add(const ForgotTypeView());
      forgotController.state.pageIndex++;

      forgotController.pageController.animateToPage(
        forgotController.state.pageCount.length - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      getSnackTop('信息不匹配，请重新输入');
      textController.text = '';
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 200), () {
      focusNode.requestFocus();
    });
    textController.addListener(() {
      if (textController.text.length < 7) {
        state.isDissable = true;
      } else {
        state.isDissable = false;
      }
    });
  }
}
