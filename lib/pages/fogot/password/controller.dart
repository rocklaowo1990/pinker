import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/user.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/global.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/password/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class ForgotPasswordController extends GetxController {
  /// 文本控制器
  final TextEditingController textController = TextEditingController();

  /// 焦点控制器
  final FocusNode focusNode = FocusNode();

  /// 状态控制器
  final ForgotPasswordState state = ForgotPasswordState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  /// 下一步
  void handleNext() async {
    getDialog();
    Map<String, dynamic> data = {
      'userId': '${forgotController.userInfo.userId}',
      'code': '${forgotController.publicData['code']}',
      'newPassword': duMD5(textController.text),
      'type': '${forgotController.state.verifyType}',
    };

    ResponseEntity _resetPassword = await UserApi.resetPassword(data);

    if (_resetPassword.code == 200) {
      /// 储存Token
      await Global.saveToken(_resetPassword.data!['token']);

      /// 去往首页
      await futureMill(500);

      Get.back();
      Get.offAllNamed(AppRoutes.application);
    } else {
      await futureMill(500);
      Get.back();
      textController.clear();
      getSnackTop(_resetPassword.msg);
    }
  }

  @override
  void onInit() {
    super.onInit();
    textController.addListener(() {
      String text = textController.text;
      state.isDissable = isPassword(text) ? false : true;
    });
  }
}
