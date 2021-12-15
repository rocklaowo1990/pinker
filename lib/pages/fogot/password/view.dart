import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/fogot/password/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getSpan('设置您的密码', fontSize: 26);

    /// 头像
    Widget avatar = Container(
      width: 40.w,
      height: 40.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondBacground,
      ),
      child: Center(
          child: getImageBox(
        controller.forgotController.forgotInfo.avatar,
        shape: BoxShape.circle,
      )),
    );

    /// 昵称
    Widget nickName = getSpan(
      controller.forgotController.forgotInfo.nickName,
      fontSize: 17,
    );

    /// 用户名
    Widget userName = getSpan(
      '@${controller.forgotController.forgotInfo.userName}',
      color: AppColors.secondText,
    );

    /// 账号输入框
    Widget userPassword = getInput(
      type: Lang.inputPassword.tr,
      controller: controller.textController,
      focusNode: controller.focusNode,
      textInputAction: TextInputAction.next,
    );

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: Obx(
        () => getButton(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
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
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  title,
                  SizedBox(height: 10.h),
                  avatar,
                  SizedBox(height: 10.h),
                  nickName,
                  SizedBox(height: 1.h),
                  userName,
                  SizedBox(height: 10.h),
                  userPassword,
                ],
              ),
            ),
          ),
        ),
        bottom,
      ],
    );
    return Obx(() => controller.forgotController.state.pageIndex != 4
        ? Stack(
            // 遮罩层
            children: [body, Container(color: Colors.black12)],
          )
        : body);
  }
}
