import 'package:flutter/gestures.dart';
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
    Widget title = getSpan(Lang.registerTitle.tr, fontSize: 26);

    /// 账号输入框
    Widget userRegister = Obx(() => getInput(
          type: controller.state.isPhone
              ? Lang.inputPhone.tr
              : Lang.inputEmail.tr,
          controller: controller.textController,
          autofocus: true,
          focusNode: controller.focusNode,
          prefixIcon: controller.state.isPhone
              ? getButton(
                  child: getSpan(
                    '+${controller.state.code}',
                    color: AppColors.mainColor,
                  ),
                  background: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.w, right: 5.w),
                  onPressed: controller.handleGoCodeList,
                )
              : null,
        ));

    /// 生日输入框
    Widget userBirth = Obx(
      () => getButton(
        padding: EdgeInsets.only(left: 10.w, top: 8.h, bottom: 8.h),
        onPressed: controller.birthChoice,
        child: getSpan(
            '${controller.state.showTime.year}-${controller.state.showTime.month}-${controller.state.showTime.day}'),
        alignment: Alignment.centerLeft,
        background: AppColors.inputFiled,
        width: double.infinity,
      ),
    );

    /// 单选按钮默认状态
    Widget dialogDefault = Icon(
      Icons.check_circle,
      size: 8.w,
      color: AppColors.mainColor,
    );

    /// 单选按钮选中状态
    Widget dialogChooise = Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 0.8.w,
          color: AppColors.thirdIcon,
        ),
      ),
    );

    /// 服务条款 和 隐私政策富文本
    Widget richText = RichText(
      text: TextSpan(
        text: Lang.registerAgreen_1.tr,
        style: const TextStyle(color: AppColors.secondText, fontSize: 15),
        children: [
          TextSpan(
            text: Lang.registerService.tr,
            style: const TextStyle(color: AppColors.mainColor, fontSize: 15),
            recognizer: TapGestureRecognizer()
              ..onTap = controller.handleGoService,
          ),
          TextSpan(
            text: Lang.registerAgreen_2.tr,
            style: const TextStyle(color: AppColors.secondText, fontSize: 15),
          ),
          TextSpan(
            text: Lang.registerPrivacy.tr,
            style: const TextStyle(color: AppColors.mainColor, fontSize: 15),
            recognizer: TapGestureRecognizer()
              ..onTap = controller.handleGoPrivacy,
          ),
        ],
      ),
    );

    /// 同意服务条款
    Widget agreen = getButton(
      overlayColor: Colors.transparent,
      onPressed: controller.handleAgreen,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      background: Colors.transparent,
      child: Row(
        children: [
          Obx(() => controller.state.isChooise ? dialogDefault : dialogChooise),
          SizedBox(width: 4.w),
          Expanded(child: richText, flex: 1),
        ],
      ),
    );

    /// 底部
    Widget bottom = getBottomBox(
      leftWidget: getButton(
        child: Obx(
          () => getSpan(
            controller.state.isPhone
                ? Lang.registerPhone.tr
                : Lang.registerEmail.tr,
            color: AppColors.mainColor,
          ),
        ),
        onPressed: controller.handleChangeRegister,
        background: Colors.transparent,
      ),
      rightWidget: Obx(
        () => getButton(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: getSpan(Lang.next.tr),
          onPressed:
              !controller.state.isAccountPass && controller.state.isChooise
                  ? controller.handleNext
                  : null,
          background:
              !controller.state.isAccountPass && controller.state.isChooise
                  ? AppColors.mainColor
                  : AppColors.buttonDisable,
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
                  SizedBox(height: 4.h),
                  userBirth,
                  SizedBox(height: 4.h),
                  agreen,
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          flex: 1,
        ),
        bottom,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != 1
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
