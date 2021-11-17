import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    Widget title = getSpan(Lang.loginTitle.tr, fontSize: 26);

    /// 账号输入框
    Widget userCount = getInput(
      type: Lang.inputCount.tr,
      controller: controller.userCountController,
      autofocus: true,
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
      leftWidget: getButton(
        child: getSpan(Lang.loginForget.tr, color: AppColors.mainColor),
        onPressed: controller.handleGoForgetPasswordPage,
        height: 18.h,
        background: Colors.transparent,
      ),
      rightWidget: Obx(
        () => getButton(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
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
              SizedBox(height: 4.h),
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
