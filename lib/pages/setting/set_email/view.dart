import 'package:flutter/material.dart';

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
    AppBar appBar = getSettingBar('更改邮箱地址');

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: Obx(
        () => getButtonSheet(
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
      focusNode: controller.focusNode,
    );

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              getTitle('更改邮箱地址'),
              const SizedBox(height: 20),
              getSpan('输入您想要更改的与账号关联的邮箱地址', color: AppColors.secondText),
              getSpan('您将通过此邮箱接收验证码', color: AppColors.secondText),
              const SizedBox(height: 20),
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
