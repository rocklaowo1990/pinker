import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/password/library.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

class PasswordView extends GetView<PasswordController> {
  const PasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getTitle(Lang.passwordTitle.tr);

    /// 副标题1
    Widget secndTitle = getSpanSecond(Lang.passwordSecondTitle.tr);

    /// 副标题2
    Widget thirdTitle = getSpanSecond(Lang.passwordThirdTitle.tr);

    /// 密码输入框
    Widget userPassword = getInput(
      type: Lang.inputPassword.tr,
      controller: controller.passwordController,
      focusNode: controller.passwordFocusNode,
    );

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

    /// body布局
    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24,
            right: 20,
            left: 20,
          ),
          child: Column(
            children: [
              title,
              const SizedBox(height: 20),
              secndTitle,
              const SizedBox(height: 4),
              thirdTitle,
              const SizedBox(height: 30),
              userPassword,
            ],
          ),
        ),
        bottom,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != -1
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
