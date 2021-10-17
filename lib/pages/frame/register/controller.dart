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
  RxBool nextButtonDisable = true.obs;

  void _listenerButton() {
    nextButtonDisable.value =
        userRegisterController.text.isNotEmpty ? false : true;
  }

  @override
  void onInit() {
    super.onInit();
    userRegisterController.addListener(() {
      _listenerButton();
    });
  }

  void handleNext() {
    /// 防抖
    nextButtonDisable.value = true;

    /// 启用按钮
    Future.delayed(const Duration(seconds: 3), () {
      nextButtonDisable.value = false;
    });
  }

  void birthChoice() {
    userRegisterFocusNode.unfocus();
    dateBottom(title: 'asfsafas');
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
