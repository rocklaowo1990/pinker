import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/api.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class LoginController extends GetxController {
  final indexController = Get.put(FrameController());

  final TextEditingController userCountController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  final FocusNode userCountFocusNode = FocusNode();
  final FocusNode userPasswordFocusNode = FocusNode();

  /// 去找回密码页面
  void handleGoForgetPasswordPage() {}

  /// 用户登陆
  void handleSignIn() async {
    /// 账号为空，退出
    if (userCountController.text.isEmpty) {
      snackbar(title: '请输入手机号码、邮箱或账号');
      FocusScope.of(Get.context!).requestFocus(userCountFocusNode);
      return;
    }

    /// 密码为空，退出
    if (userPasswordController.text.isEmpty) {
      snackbar(title: '密码不能为空');
      FocusScope.of(Get.context!).requestFocus(userPasswordFocusNode);
      return;
    }

    /// 准备请求数据
    Map<String, String> data = {
      'account': userCountController.text,
      'password': duMD5(userPasswordController.text),
      'accountType': '1',
    };

    /// 等待请求结果
    var userProfile = await AccountApi.signIn(data: data);

    /// 返回数据处理
    if (userProfile['code'] == 200) {
      Global.saveProfile(userProfile['data']['token']);
      Global.saveAlreadyOpen();
      Get.offAllNamed('/application');
    } else {
      snackbar(title: userProfile['msg']);
    }
  }

  @override
  void dispose() {
    indexController.dispose();

    userCountController.dispose();
    userPasswordController.dispose();

    userCountFocusNode.dispose();
    userPasswordFocusNode.dispose();

    super.dispose();
  }
}
