import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/login/index.dart';

import 'package:pinker/widgets/widgets.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = span(text: Lang.loginTitle.tr, size: 16.sp);

    /// 账号输入框
    Widget userCount = input(
      type: Lang.inputCount.tr,
      controller: controller.userCountController,
      autofocus: true,
      focusNode: controller.userCountFocusNode,
      textInputAction: TextInputAction.next,
      enabled: controller.loading,
    );

    /// 密码输入框
    Widget userPassword = input(
      type: Lang.inputPassword.tr,
      controller: controller.userPasswordController,
      focusNode: controller.userPasswordFocusNode,
      enabled: controller.loading,
    );

    Widget bottom = bottomButton(
      onPressedLeft: controller.handleGoForgetPasswordPage,
      onPressedRight: controller.handleSignIn,
      disable: controller.buttonDisable,
      loading: controller.loading,
      textLeft: Lang.loginForget.tr,
      textRight: Lang.loginButton.tr,
    );

    /// body布局
    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            right: 20.w,
            left: 20.w,
          ),
          child: Column(
            children: [
              title,
              SizedBox(height: 30.h),
              userCount,
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: userPassword,
              ),
            ],
          ),
        ),
        bottom,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => !controller.indexController.isShow.value
            ? Stack(
                // 遮罩层
                children: [
                  body,
                  Container(
                    color: Colors.black12,
                  )
                ],
              )
            : body,
      ),
    );
  }
}
