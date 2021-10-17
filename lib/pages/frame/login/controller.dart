import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/api.dart';
import 'package:pinker/entities/user.dart';
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

  /// 默认按钮为禁用状态
  RxBool loginButtonDisable = false.obs;

  /// 关闭键盘
  void _unfocus() {
    userCountFocusNode.unfocus();
    userPasswordFocusNode.unfocus();
  }

  /// 去找回密码页面
  void handleGoForgetPasswordPage() {
    _unfocus();
    const localZH = Locale('zh', 'CN');
    const localEN = Locale('en', 'US');
    Get.updateLocale(Get.locale == localEN ? localZH : localEN);
  }

  /// 用户登陆
  void handleSignIn() async {
    /// 关闭键盘
    _unfocus();

    /// 防抖
    loginButtonDisable.value = true;

    /// 账号为空，退出
    if (userCountController.text.isEmpty) {
      snackbar(title: '请输入手机号码、邮箱或账号');
      userCountFocusNode.requestFocus();
      loginButtonDisable.value = false;
      return;
    }

    /// 密码为空，退出
    if (userPasswordController.text.isEmpty) {
      snackbar(title: '密码不能为空');
      userPasswordFocusNode.requestFocus();
      loginButtonDisable.value = false;
      return;
    }

    /// 判断账号类型
    String _accoutnType() {
      if (userCountController.text.isNum) return '1';
      if (userCountController.text.isEmail) return '2';
      return '3';
    }

    /// 准备请求数据
    Map<String, String> data = {
      'account': userCountController.text,
      'password': duMD5(userPasswordController.text),
      'accountType': _accoutnType(),
    };

    /// 请求服务器...
    UserLoginResponseEntity userProfile = await AccountApi.signIn(data: data);

    /// 返回数据处理
    if (userProfile.code == 200) {
      // 储存用户数据
      Global.saveProfile(userProfile);
      // 储存第一次登陆信息
      Global.saveAlreadyOpen();
      // 去往首页
      Get.offAllNamed('/application');
    } else {
      // 返回错误信息
      /// 3 秒后重新启用按钮
      await Future.delayed(const Duration(seconds: 2), () {
        loginButtonDisable.value = false;
      });
      await Future.delayed(const Duration(milliseconds: 200), () {
        userCountFocusNode.requestFocus();
        snackbar(title: userProfile.msg);
      });
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
