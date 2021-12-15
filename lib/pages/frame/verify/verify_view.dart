import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/dynamic_page/dynamic_page.dart';
import 'package:pinker/pages/frame/verify/library.dart';

class VerifyView extends GetView<VerifyController> {
  const VerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// body 布局
    Widget body = getVerifyView(
      isVerify: controller.isVerify,
      result: controller.next,
      resendCode: controller.sendCode,
      time: controller.frameController.state.sendTimeRx,
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != 2
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
