import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/fogot/verify/library.dart';

import 'package:pinker/widgets/verify.dart';

class ForgotVerifyView extends StatelessWidget {
  const ForgotVerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotVerifyController>(
      init: ForgotVerifyController(),
      builder: (controller) {
        /// body
        Widget body = getVerifyView(
          result: controller.handleNext,
          isVerify: controller.isVerify,
          resendCode: controller.sendCode,
          time: controller.forgotController.state.sendTimeRx,
        );
        return Obx(() => controller.forgotController.state.pageIndex != 3
            ? Stack(
                // 遮罩层
                children: [body, Container(color: Colors.black12)],
              )
            : body);
      },
    );
  }
}
