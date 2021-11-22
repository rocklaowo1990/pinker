import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/set_email/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetEmailView extends GetView<SetEmailController> {
  const SetEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('更改邮箱地址', fontSize: 17),
      backgroundColor: AppColors.mainBacground,
      lineColor: AppColors.line,
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

    /// 邮箱
    Widget userRegister = getInput(
      type: Lang.inputEmail.tr,
      controller: controller.textController,
      autofocus: true,
      focusNode: controller.focusNode,
    );

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              getSpan('更改邮箱地址', fontSize: 26),
              SizedBox(height: 8.h),
              getSpan('输入您想要更改的与账号关联的邮箱地址', color: AppColors.secondText),
              getSpan('您将通过此邮箱接收验证码', color: AppColors.secondText),
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
