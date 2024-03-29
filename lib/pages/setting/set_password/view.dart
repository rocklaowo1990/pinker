import 'package:flutter/material.dart';

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
    AppBar appBar = getSettingBar('更改密码');

    /// 底部
    Widget bottom = getBottomBox(
      leftWidget: getButtonTransparent(
        child: getSpan('忘记密码？', color: AppColors.mainColor),
        onPressed: controller.handleReset,
      ),
      rightWidget: Obx(
        () => getButtonSheet(
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              old,
              const SizedBox(height: 4),
              newOne,
              const SizedBox(height: 4),
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
