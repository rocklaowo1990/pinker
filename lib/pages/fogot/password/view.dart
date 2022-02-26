import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/fogot/password/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getTitle('认证您的个人信息');

    /// 头像
    Widget avatar = getNetworkImageBox(
      controller.forgotController.forgotInfo.avatar,
      shape: BoxShape.circle,
      width: 60,
      height: 60,
    );

    /// 昵称
    Widget nickName =
        getSpanTitle(controller.forgotController.forgotInfo.nickName);

    /// 用户名
    Widget userName =
        getSpanSecond('@${controller.forgotController.forgotInfo.userName}');

    /// 密码输入框
    Widget userPassword = getInput(
      type: Lang.inputPassword.tr,
      controller: controller.textController,
      focusNode: controller.focusNode,
      textInputAction: TextInputAction.next,
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
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  title,
                  const SizedBox(height: 20),
                  avatar,
                  const SizedBox(height: 20),
                  nickName,
                  const SizedBox(height: 4),
                  userName,
                  const SizedBox(height: 20),
                  userPassword,
                ],
              ),
            ),
          ),
        ),
        bottom,
      ],
    );
    return Obx(() => controller.forgotController.state.pageIndex != 4
        ? Stack(
            // 遮罩层
            children: [body, Container(color: Colors.black12)],
          )
        : body);
  }
}
