import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/fogot/type/library.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class ForgotTypeView extends GetView<ForgotTypeController> {
  const ForgotTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getTitle('您想要通过何种方式重置密码');

    /// 副标题
    Widget titleSecond = getSpanSecond('可以使用于您的账号关联的信息');

    /// 手机验证列表
    Widget listPhone = getButtonList(
        icon: Obx(() => getCheckIcon(
            isChooise: controller.forgotController.state.verifyType == 1
                ? true
                : false)),
        iconRight: const SizedBox(),
        onPressed: controller.handlePhoneType,
        title:
            '向尾号 ${getLastTwo(controller.forgotController.forgotInfo.phone)} 的电话号码发送验证码');

    /// 邮箱验证列表
    Widget listEmail = getButtonList(
        icon: Obx(() => getCheckIcon(
            isChooise: controller.forgotController.state.verifyType == 2
                ? true
                : false)),
        iconRight: const SizedBox(),
        onPressed: controller.handleEmailType,
        title:
            '向尾号 ${getEmailHide(controller.forgotController.forgotInfo.email)} 的电子邮箱发送验证码');

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: getButtonSheet(
        child: getSpan(Lang.next.tr),
        onPressed: controller.handleNext,
        // background: AppColors.mainColor,
      ),
    );

    /// body布局
    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  title,
                  const SizedBox(height: 20),
                  titleSecond,
                ],
              ),
            ),
            if (controller.forgotController.forgotInfo.phone != '') listPhone,
            if (controller.forgotController.forgotInfo.email != '')
              const SizedBox(height: 8),
            if (controller.forgotController.forgotInfo.email != '') listEmail,
          ],
        ),
        bottom,
      ],
    );
    return Obx(() => controller.forgotController.state.pageIndex != 2
        ? Stack(
            // 遮罩层
            children: [body, Container(color: Colors.black12)],
          )
        : body);
  }
}
