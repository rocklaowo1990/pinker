import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/frame/register/controller.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    var title = span(text: '创建您的账号', size: 16.sp);

    /// 账号输入框
    var userRegister = Obx(
      () => input(
        type:
            controller.phoneRegister.value ? InputType.phone : InputType.email,
        controller: controller.userRegisterController,
        autofocus: true,
        focusNode: controller.userRegisterFocusNode,
      ),
    );

    /// 生日输入框
    var userBirth = buttonWidget(
      onPressed: controller.birthChoice,
      text: '1990 年 1 月 1 日',
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.w),
      background: AppColors.inputFiled,
    );

    /// 改用电子邮箱
    var forgetPasswordButton = Obx(
      () => buttonWidget(
        onPressed: controller.handleChangeRegister,
        text: controller.phoneRegister.value ? '改用电子邮箱' : '改用手机',
        width: controller.phoneRegister.value ? 56.h : 40.h,
        height: 16.h,
        background: Colors.transparent,
        textColor: AppColors.main,
      ),
    );

    /// 下一步按钮
    var nextButton = Obx(
      () => buttonWidget(
        onPressed:
            controller.nextButtonDisable.value ? () {} : controller.handleNext,
        width: 40.w,
        height: 18.h,
        text: '下一步',
        textColor:
            controller.nextButtonDisable.value ? AppColors.darkText : null,
        background:
            controller.nextButtonDisable.value ? AppColors.buttonDisable : null,
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
          nextButton,
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
