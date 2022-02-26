import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/set_user_name/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetUserNameView extends GetView<SetUserNameController> {
  const SetUserNameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getSettingBar('更改用户名');

    /// 底部
    Widget bottom = getBottomBox(
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

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  getSpanSecond('当前用户名'),
                  const SizedBox(height: 8),
                  getSpanTitle(controller
                      .applicationController.state.userInfo.value.userName),
                  const SizedBox(height: 20),
                  getInput(
                    type: '输入新的用户名',
                    controller: controller.textController,
                    focusNode: controller.focusNode,
                  ),
                  const SizedBox(height: 20),
                  getSpan('6-16位字母开头，允许包含数字和下划线', color: AppColors.secondText),
                  const SizedBox(height: 10),
                  getSpan('*用户名只能修改一次，请认真填写', color: AppColors.errro),
                ],
              ),
            ),
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
