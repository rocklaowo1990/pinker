import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/fogot/info/library.dart';
import 'package:pinker/pages/fogot/library.dart';

import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
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

  void handleNext() async {
    getDialog();
    if (textController.text == forgotController.userInfo.phone ||
        textController.text == forgotController.userInfo.email) {
      textController.clear();

      await futureMill(500);
      Get.back();
      forgotController.state.pageIndex++;
      Get.offNamed(AppRoutes.forgotType, id: 3);
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop('信息不匹配，请重新输入');
      textController.clear();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 200), () {
      focusNode.requestFocus();
    });
    textController.addListener(() {
      String text = textController.text;
      state.isDissable = duCheckStringLength(text, 7) ? false : true;
    });
  }
}
