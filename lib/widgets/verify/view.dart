import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getVerifyView({
  required Future<bool> Function(String text) isVerify,
  required VoidCallback result,
  required VoidCallback resendCode,
  required RxInt time,
}) {
  return GetBuilder<WidgetsVerifyController>(
    init: WidgetsVerifyController(),
    builder: (controller) {
      /// 标题
      Widget title = getTitle(Lang.codeTile.tr);

      /// 副标题
      Widget secndTitle = getSpan(
        Lang.codeSendTile.tr,
        color: AppColors.secondText,
      );

      /// 验证码输入框
      Widget codeInput = Offstage(
        offstage: true,
        child: TextField(
          onChanged: (text) {
            controller.onChanged(text, isVerify, result);
          },
          keyboardType: TextInputType.number,
          controller: controller.inputController,
          focusNode: controller.focusNode, // 焦点
          decoration: const InputDecoration(
            counterText: '',
          ),
          maxLength: 6,
        ),
      );

      Widget _codeChild(int index) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            border: Border.all(
              color: controller.state.codeList.length >= index
                  ? AppColors.mainColor
                  : AppColors.thirdIcon,
              width: 1,
            ),
          ),
          child: Center(
            child: controller.state.codeList.length == index
                ? AnimatedOpacity(
                    opacity: controller.state.opacity,
                    duration: const Duration(milliseconds: 500),
                    alwaysIncludeSemantics: true,
                    onEnd: controller.handleOnEnd,
                    child: Container(
                        width: 1.5, height: 16, color: AppColors.mainColor),
                  )
                : controller.state.codeList.length < index
                    ? null
                    : getSpan(
                        controller.state.codeList[index],
                        fontSize: 20,
                        color: AppColors.mainColor,
                      ),
          ),
        );
      }

      /// 验证码输入框
      Widget codeShow = getButton(
        background: Colors.transparent,
        overlayColor: Colors.transparent,
        onPressed: controller.handleOnPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => _codeChild(0)),
            Obx(() => _codeChild(1)),
            Obx(() => _codeChild(2)),
            Obx(() => _codeChild(3)),
            Obx(() => _codeChild(4)),
            Obx(() => _codeChild(5)),
          ],
        ),
      );

      /// 重新发送验证码
      Widget resendButton = Obx(() => getButton(
            child: time.value <= 0
                ? getSpanMain(Lang.codeResend.tr)
                : getSpanSecond('${Lang.codeResend.tr} ( ${time.value} )'),
            padding: const EdgeInsets.only(left: 10, right: 10),
            background: Colors.transparent,
            onPressed: time.value <= 0 ? resendCode : null,
          ));

      /// body 布局
      Widget body = Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    title,
                    const SizedBox(height: 20),
                    secndTitle,
                    const SizedBox(height: 32),
                    codeShow,
                    const SizedBox(height: 32),
                    resendButton,
                  ],
                ),
              ),
            ),
            codeInput,
          ],
        ),
      );
      return body;
    },
  );
}
