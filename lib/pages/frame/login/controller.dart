import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/api.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/login/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class LoginController extends GetxController {
  final frameController = Get.put(FrameController());

  final TextEditingController userCountController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  final FocusNode userCountFocusNode = FocusNode();
  final FocusNode userPasswordFocusNode = FocusNode();

  final state = LoginState();

  /// 关闭键盘
  void _unfocus() {
    userCountFocusNode.unfocus();
    userPasswordFocusNode.unfocus();
  }

  /// 输入框文本监听
  void _textListener() {
    state.isDissable =
        userCountController.text.isEmpty || userPasswordController.text.isEmpty
            ? true
            : false;
  }

  /// 初始化
  @override
  void onInit() {
    super.onInit();
    userCountController.addListener(() {
      _textListener();
    });
    userPasswordController.addListener(() {
      _textListener();
    });
  }

  /// 去找回密码页面
  void handleGoForgetPasswordPage() async {
    if (userCountFocusNode.hasFocus || userPasswordFocusNode.hasFocus) {
      _unfocus();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    Get.toNamed(AppRoutes.forgot);
  }

  /// 用户登陆
  void handleSignIn() async {
    /// 关闭键盘
    _unfocus();

    await Future.delayed(const Duration(milliseconds: 200));
    getDialog();

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
    ResponseEntity userProfile = await AccountApi.login(data);

    /// 返回数据处理
    if (userProfile.code == 200) {
      /// 储存用户数据
      await Global.saveProfile(userProfile);

      /// 储存第一次登陆信息
      // Global.saveAlreadyOpen();

      /// 去往首页
      Get.offAllNamed(AppRoutes.application);
    } else {
      Get.back();

      /// 返回错误信息
      await Future.delayed(const Duration(milliseconds: 200), () {
        userCountFocusNode.requestFocus();
        getSnackTop(userProfile.msg);
      });
    }
  }

  @override
  void dispose() {
    userCountController.dispose();
    userPasswordController.dispose();

    userCountFocusNode.dispose();
    userPasswordFocusNode.dispose();

    frameController.dispose();
    super.dispose();
  }
}
