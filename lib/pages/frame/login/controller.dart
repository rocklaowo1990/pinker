import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/api/api.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/login/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class LoginController extends GetxController {
  final FrameController frameController = Get.find();

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

  @override
  void onReady() {
    super.onReady();
    userCountFocusNode.requestFocus();
    userCountController.addListener(() {
      _textListener();
    });
    userPasswordController.addListener(() {
      _textListener();
    });
  }

  /// 输入框文本监听
  void _textListener() {
    state.isDissable =
        userCountController.text.isEmpty || userPasswordController.text.isEmpty
            ? true
            : false;
  }

  /// 找回密码
  void handleGoForgetPasswordPage() async {
    /// 打开找回密码页面
    Get.bottomSheet(
      const ForgotView(),
      isScrollControlled: true, //全屏高度
      // enableDrag: false, //下滑手势：关闭
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }

  /// 用户登陆
  void handleSignIn() async {
    /// 关闭键盘
    _unfocus();
    getDialog();

    /// 判断账号类型
    String _accoutnType() {
      if (userCountController.text.isNum) return '1';
      if (userCountController.text.isEmail) return '2';
      return '3';
    }

    /// 请求服务器...
    ResponseEntity login = await AccountApi.login(
      account: userCountController.text,
      password: duMD5(userPasswordController.text),
      accountType: _accoutnType(),
    );

    /// 返回数据处理
    if (login.code == 200) {
      /// 全局token赋值
      Global.token = login.data['token'];

      /// 储存Token
      await Global.saveToken(Global.token!);

      /// 去往首页
      await futureMill(500);

      Get.back();
      Get.offAllNamed(AppRoutes.application);
    } else {
      /// 返回错误信息
      await futureMill(500);

      Get.back();
      userCountFocusNode.requestFocus();
      getSnackTop(login.msg);
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
