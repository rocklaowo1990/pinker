import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/frame/login/index.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    var title = span(text: '登陆 Pinker', size: 16.sp);

    /// 账号输入框
    var userCount = input(
      type: InputType.count,
      controller: controller.userCountController,
      autofocus: true,
      focusNode: controller.userCountFocusNode,
      textInputAction: TextInputAction.next,
    );

    /// 密码输入框
    var userPassword = input(
      type: InputType.password,
      controller: controller.userPasswordController,
      focusNode: controller.userPasswordFocusNode,
    );

    /// 找回密码按钮
    var forgetPasswordButton = buttonWidget(
      onPressed: controller.handleGoForgetPasswordPage,
      text: '忘记密码',
      width: 40.h,
      height: 16.h,
      background: Colors.transparent,
      textColor: AppColors.main,
    );

    /// 登陆按钮
    var loginButton = Obx(
      () => buttonWidget(
        onPressed: controller.loginButtonDisable.value
            ? () {}
            : controller.handleSignIn,
        width: 40.w,
        height: 18.h,
        text: '登陆',
        textColor:
            controller.loginButtonDisable.value ? AppColors.darkText : null,
        background: controller.loginButtonDisable.value
            ? AppColors.buttonDisable
            : null,
      ),
    );

    /// 底部 bottom 布局
    var bottom = Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      width: double.infinity,
      height: 25.h,
      color: AppColors.backgroundLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          forgetPasswordButton,
          loginButton,
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
              SizedBox(height: 6.h),
              userPassword,
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
