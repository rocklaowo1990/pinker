import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/check_password/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CheckPasswordView extends GetView<CheckPasswordController> {
  const CheckPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('验证您的身份', fontSize: 17),
      backgroundColor: AppColors.mainBacground,
      elevation: 0.5.h,
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

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              getSpan('验证您的密码', fontSize: 26),
              SizedBox(height: 8.h),
              getSpan('重新输入您的密码以继续', color: AppColors.secondText),
              SizedBox(height: 20.h),
              getInput(
                type: Lang.inputPassword.tr,
                controller: controller.textController,
                focusNode: controller.focusNode,
                autofocus: true,
              ),
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
