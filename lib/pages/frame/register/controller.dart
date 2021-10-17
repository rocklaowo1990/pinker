import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterController extends GetxController {
  final indexController = Get.put(FrameController());

  final TextEditingController userRegisterController = TextEditingController();

  final FocusNode userRegisterFocusNode = FocusNode();

  /// 判断是手机注册 还是 邮箱注册
  RxBool phoneRegister = true.obs;

  /// 默认按钮为禁用状态
  RxBool nextButtonDisable = false.obs;

  /// 关闭键盘
  void _unfocus() {
    userRegisterFocusNode.unfocus();
  }

  void handleNext() async {
    /// 关闭键盘
    _unfocus();

    /// 防抖
    nextButtonDisable.value = true;

    await Future.delayed(const Duration(seconds: 2), () {
      nextButtonDisable.value = false;
    });

    await Future.delayed(const Duration(milliseconds: 200), () {
      userRegisterFocusNode.requestFocus();
    });
  }

  void birthChoice() {
    userRegisterFocusNode.unfocus();
    dateBottom(
      date: 'Lang.sure.tr',
      onPressed: () {},
    );
  }

  void handleChangeRegister() {
    userRegisterController.text = '';
    phoneRegister.value = !phoneRegister.value;
    userRegisterFocusNode.requestFocus();
  }

  @override
  void dispose() {
    indexController.dispose();

    userRegisterController.dispose();

    userRegisterFocusNode.dispose();

    super.dispose();
  }
}
