import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/dynamic_page/dynamic_page.dart';
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
      Widget title = getSpan(
        Lang.codeTile.tr,
        fontSize: 26,
        textAlign: TextAlign.center,
      );

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
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
            border: Border.all(
              color: controller.state.codeList.length >= index
                  ? AppColors.mainColor
                  : AppColors.thirdIcon,
              width: 0.8.w,
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
                        width: 1.w, height: 10.w, color: AppColors.mainColor),
                  )
                : controller.state.codeList.length < index
                    ? null
                    : getSpan(
                        controller.state.codeList[index],
                        fontSize: 26,
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
                ? getSpan(Lang.codeResend.tr, color: AppColors.mainColor)
                : getSpan(
                    '${Lang.codeResend.tr} ( ${time.value} )',
                    color: AppColors.secondText,
                  ),
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            background: Colors.transparent,
            onPressed: time.value <= 0 ? resendCode : null,
          ));

      /// body 布局
      Widget body = Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    title,
                    SizedBox(height: 8.h),
                    secndTitle,
                    SizedBox(height: 32.h),
                    codeShow,
                    SizedBox(height: 16.h),
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
