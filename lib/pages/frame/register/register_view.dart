import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/register/controller.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getSpan(Lang.registerTitle.tr, size: 16.sp);

    /// 账号输入框
    Widget userRegister = Obx(
      () => getInput(
        type: controller.phoneRegister.value
            ? Lang.inputPhone.tr
            : Lang.inputEmail.tr,
        controller: controller.userRegisterController,
        autofocus: true,
        focusNode: controller.userRegisterFocusNode,
      ),
    );

    /// 生日输入框
    Widget userBirth = Obx(
      () => getButton(
        onPressed: controller.birthChoice,
        child: getSpan(
            '${controller.dateTime.value.year}-${controller.dateTime.value.month}-${controller.dateTime.value.day}'),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10.w),
        background: AppColors.inputFiled,
        width: double.infinity,
      ),
    );

    /// 底部
    Widget bottom = getBottomBox(
      leftWidget: getButton(
        child: Obx(
          () => getSpan(
            controller.phoneRegister.value
                ? Lang.registerPhone.tr
                : Lang.registerEmail.tr,
            color: AppColors.mainColor,
          ),
        ),
        height: 18.h,
        onPressed: controller.handleChangeRegister,
        background: Colors.transparent,
      ),
      rightWidget: Obx(
        () => getButton(
          width: 40.w,
          height: 18.h,
          child: getSpan(Lang.registerNext.tr),
          onPressed:
              controller.buttonDisable.value ? null : controller.handleNext,
          background: controller.buttonDisable.value
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
              userRegister,
              SizedBox(height: 6.h),
              userBirth,
            ],
          ),
        ),
        bottom,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => !controller.frameController.isShow.value
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
