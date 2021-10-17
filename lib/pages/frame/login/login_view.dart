import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/login/index.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    var title = span(text: Lang.loginTitle.tr, size: 16.sp);

    /// 账号输入框
    var userCount = input(
      type: Lang.inputCount.tr,
      controller: controller.userCountController,
      autofocus: true,
      focusNode: controller.userCountFocusNode,
      textInputAction: TextInputAction.next,
      enabled: controller.loginButtonDisable,
    );

    /// 密码输入框
    var userPassword = input(
      type: Lang.inputPassword.tr,
      controller: controller.userPasswordController,
      focusNode: controller.userPasswordFocusNode,
      enabled: controller.loginButtonDisable,
    );

    /// 找回密码按钮
    var forgetPasswordButton = buttonWidget(
      onPressed: controller.handleGoForgetPasswordPage,
      text: Lang.loginForget.tr,
      height: 16.h,
      background: Colors.transparent,
      textColor: AppColors.mainColor,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 5.w),
    );

    /// 登陆按钮
    var loginButton = buttonWidget(
      onPressed: controller.handleSignIn,
      width: 40.w,
      height: 18.h,
      text: Lang.loginButton.tr,
    );

    /// 登陆按钮禁用状态
    var loginButtonDisable = Container(
        width: 40.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: AppColors.buttonDisable,
          borderRadius: BorderRadius.all(Radius.circular(187.5.w)),
        ),
        child: Center(
          child: SizedBox(
            width: 10.h,
            height: 10.h,
            child: const CircularProgressIndicator(
              color: AppColors.mainText,
              strokeWidth: 2.0,
            ),
          ),
        ));

    /// 底部 bottom 布局
    var bottom = Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      width: double.infinity,
      height: 25.h,
      color: AppColors.secondBacground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: forgetPasswordButton),
          Obx(
            () => controller.loginButtonDisable.value
                ? loginButtonDisable
                : loginButton,
          ),
        ],
      ),
    );

    /// body布局
    var body = Column(
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
