import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/api.dart';
import 'package:pinker/entities/user.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class LoginController extends GetxController {
  final frameController = Get.put(FrameController());

  final TextEditingController userCountController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  final FocusNode userCountFocusNode = FocusNode();
  final FocusNode userPasswordFocusNode = FocusNode();

  /// 按钮专用禁用状态
  RxBool buttonDisable = true.obs;

  /// 关闭键盘
  void _unfocus() {
    userCountFocusNode.unfocus();
    userPasswordFocusNode.unfocus();
  }

  /// 输入框文本监听
  void _textListener() {
    buttonDisable.value =
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
    _unfocus();
    Get.dialog(
      Container(),
      barrierDismissible: false,
    );
    await Future.delayed(const Duration(seconds: 3), () {});
    Get.back();
  }

  /// 用户登陆
  void handleSignIn() async {
    /// 关闭键盘
    _unfocus();

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
      /// 储存用户数据
      Global.saveProfile(userProfile);

      /// 储存第一次登陆信息
      Global.saveAlreadyOpen();

      /// 去往首页
      Get.offAllNamed('/application');
    } else {
      /// 返回错误信息
      /// 3 秒后重新启用按钮
      await Future.delayed(const Duration(milliseconds: 200), () {
        userCountFocusNode.requestFocus();
        getSnackTop(msg: userProfile.msg);
      });
    }
  }

  @override
  void dispose() {
    frameController.dispose();

    userCountController.dispose();
    userPasswordController.dispose();

    userCountFocusNode.dispose();
    userPasswordFocusNode.dispose();

    super.dispose();
  }
}
