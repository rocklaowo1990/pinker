import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/password/library.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

class PasswordView extends GetView<PasswordController> {
  const PasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getSpan(Lang.passwordTitle.tr, size: 16.sp);

    /// 副标题1
    Widget secndTitle = getSpan(
      Lang.passwordSecondTitle.tr,
      color: AppColors.secondText,
      textAlign: TextAlign.center,
    );

    /// 副标题2
    Widget thirdTitle = getSpan(
      Lang.passwordThirdTitle.tr,
      color: AppColors.secondText,
      textAlign: TextAlign.center,
    );

    /// 密码输入框
    Widget userPassword = getInput(
        type: Lang.inputPassword.tr,
        controller: controller.passwordController,
        focusNode: controller.passwordFocusNode,
        autofocus: true);

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: Obx(
        () => getButton(
          width: 40.w,
          height: 18.h,
          child: getSpan(Lang.next.tr),
          onPressed: controller.state.isDissable ? null : controller.handleNext,
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
              SizedBox(height: 8.h),
              secndTitle,
              SizedBox(height: 1.h),
              thirdTitle,
              SizedBox(height: 30.h),
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
        () => controller.frameController.state.pageIndex != -1
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
