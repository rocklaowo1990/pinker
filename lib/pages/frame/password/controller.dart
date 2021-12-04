import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/account.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/password/state.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class PasswordController extends GetxController {
  final FrameController frameController = Get.find();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final PasswordState state = PasswordState();

  final arguments = Get.arguments;

  /// 点击下一步按钮的执行
  void handleNext() async {
    passwordFocusNode.unfocus();
    getDialog();

    /// 准备注册请求数据
    var data = arguments;
    data['password'] = duMD5(passwordController.text);

    /// 交互：弹出loading窗口
    // passwordFocusNode.unfocus();

    /// 开始请求
    ResponseEntity registerAccount = await AccountApi.registerAccount(data);
    await Future.delayed(const Duration(milliseconds: 200));

    if (registerAccount.code == 200) {
      /// 注册成功
      /// 储存用户数据
      await Global.saveToken(registerAccount.data!['token']);

      /// 去头像设置页面
      await futureMill(500);
      Get.back();
      frameController.state.pageIndex--;
      Get.offAllNamed(AppRoutes.avatar, id: 1);

      /// 注册失败
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(registerAccount.msg);
    }
  }

  @override
  void onReady() {
    super.onReady();
    passwordFocusNode.requestFocus();
    passwordController.addListener(() {
      String text = passwordController.text;
      state.isDissable = isPassword(text) ? false : true;
    });
  }

  @override
  void dispose() {
    frameController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
