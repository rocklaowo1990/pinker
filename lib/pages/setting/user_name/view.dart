import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/setting/user_name/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetUserNameView extends GetView<SetUserNameController> {
  const SetUserNameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('更改用户名', fontSize: 17),
      backgroundColor: AppColors.mainBacground,
      elevation: 0.5.h,
    );

    /// 底部
    Widget bottom = getBottomBox(
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

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              getSpan('当前用户名', color: AppColors.secondText),
              SizedBox(height: 8.h),
              getSpan('User7788', fontSize: 17),
              SizedBox(height: 20.h),
              getInput(
                type: '输入新的用户名',
                controller: controller.textController,
                focusNode: controller.focusNode,
                autofocus: true,
              ),
              SizedBox(height: 8.h),
              getSpan('*用户名只能修改一次，请认真填写', color: AppColors.secondText),
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
