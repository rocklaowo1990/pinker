import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/setting/set_phone/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetPhoneView extends GetView<SetPhoneController> {
  const SetPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('更改手机号码', fontSize: 17),
      lineColor: AppColors.line,
      backgroundColor: AppColors.mainBacground,
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

    /// 手机输入框
    Widget userRegister = Obx(() => getInput(
          type: Lang.inputPhone.tr,
          controller: controller.textController,
          focusNode: controller.focusNode,
          prefixIcon: getButton(
            child: getSpan(
              '+${controller.state.code}',
              color: AppColors.mainColor,
            ),
            background: Colors.transparent,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.w, right: 5.w),
            onPressed: controller.handleGoCodeList,
          ),
        ));

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              getSpan('更改手机号码', fontSize: 26),
              SizedBox(height: 8.h),
              getSpan('输入您想要更改的与账号关联的手机号码', color: AppColors.secondText),
              getSpan('您将通过此号码接收验证码', color: AppColors.secondText),
              SizedBox(height: 20.h),
              userRegister,
            ],
          ),
        ),
        bottom,
      ],
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
