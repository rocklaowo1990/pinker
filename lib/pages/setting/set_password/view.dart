import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/set_password/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetPasswordView extends GetView<SetPasswordController> {
  const SetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('更改密码', fontSize: 17),
      backgroundColor: AppColors.mainBacground,
      line: AppColors.line,
    );

    /// 底部
    Widget bottom = getBottomBox(
      leftWidget: getButton(
        child: getSpan('忘记密码？', color: AppColors.mainColor),
        onPressed: controller.handleReset,
        background: Colors.transparent,
      ),
      rightWidget: Obx(
        () => getButton(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: getSpan(Lang.sure.tr),
          onPressed: controller.state.isDissable ? null : controller.handleSure,
          background: controller.state.isDissable
              ? AppColors.buttonDisable
              : AppColors.mainColor,
        ),
      ),
    );

    /// 旧密码
    Widget old = getInput(
      type: '旧密码',
      controller: controller.oldController,
      focusNode: controller.oldFocusNode,
    );

    /// 新密码——1
    Widget newOne = getInput(
      type: '新密码',
      controller: controller.newOneController,
      focusNode: controller.newOneFocusNode,
    );

    /// 新密码——2
    Widget newTwo = getInput(
      type: '重复新密码',
      controller: controller.newTwoController,
      focusNode: controller.newTwoFocusNode,
    );

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              old,
              SizedBox(height: 4.h),
              newOne,
              SizedBox(height: 4.h),
              newTwo,
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
