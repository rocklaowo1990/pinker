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
    focusNode.unfocus();
    Map<String, dynamic> data = forgotController.arguments == null
        ? {
            'userId': '${forgotController.forgotInfo.userId}',
            'code': '${forgotController.publicData['code']}',
            'newPassword': duMD5(textController.text),
            'type': '${forgotController.state.verifyType}',
          }
        : {
            'code': '${forgotController.publicData['code']}',
            'newPassword': duMD5(textController.text),
            'type': '2', //验证码方式
          };

    ResponseEntity _resetPassword = forgotController.arguments == null
        ? await UserApi.resetPassword(data)
        : await UserApi.setPassword(data);

    if (_resetPassword.code == 200) {
      if (forgotController.arguments == null) {
        /// 储存Token
        await Global.saveToken(_resetPassword.data['token']);

        /// 去往首页
        await futureMill(500);

        Get.back();
        Get.offAllNamed(AppRoutes.application);
      } else {
        await futureMill(500);

        Get.back(); // 关闭弹窗
        Get.back(); //返回密码设置页面
        Get.back(); //返回设置首页
        getSnackTop('密码修改成功', isError: false);
      }
    } else {
      await futureMill(500);
      Get.back();
      textController.clear();
      getSnackTop(_resetPassword.msg);
    }
  }

  @override
  void onReady() {
    super.onReady();
    focusNode.requestFocus();
    textController.addListener(() {
      String text = textController.text;
      state.isDissable = isPassword(text) ? false : true;
    });
  }
}
