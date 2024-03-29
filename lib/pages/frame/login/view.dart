import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/login/library.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getTitle(Lang.loginTitle.tr);

    /// 账号输入框
    Widget userCount = getInput(
      type: Lang.inputCount.tr,
      controller: controller.userCountController,
      focusNode: controller.userCountFocusNode,
      textInputAction: TextInputAction.next,
    );

    /// 密码输入框
    Widget userPassword = getInput(
      type: Lang.inputPassword.tr,
      controller: controller.userPasswordController,
      focusNode: controller.userPasswordFocusNode,
    );

    /// 底部
    Widget bottom = getBottomBox(
      leftWidget: getButtonTransparent(
        child: getSpan(Lang.loginForget.tr, color: AppColors.mainColor),
        onPressed: controller.handleGoForgetPasswordPage,
      ),
      rightWidget: Obx(
        () => getButtonSheet(
          child: getSpan(Lang.loginButton.tr),
          onPressed:
              controller.state.isDissable ? null : controller.handleSignIn,
          background: controller.state.isDissable
              ? AppColors.buttonDisable
              : AppColors.mainColor,
        ),
      ),
    );

    /// body布局
    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24,
            right: 20,
            left: 20,
          ),
          child: Column(
            children: [
              title,
              const SizedBox(height: 30),
              userCount,
              const SizedBox(height: 4),
              userPassword,
            ],
          ),
        ),
        bottom,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() => controller.frameController.state.pageIndex != 1
          ? Stack(
              // 遮罩层
              children: [
                body,
                Container(
                  color: Colors.black12,
                )
              ],
            )
          : body),
    );
  }
}
