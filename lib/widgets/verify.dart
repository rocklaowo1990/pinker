import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class VerifyWidgetController extends GetxController {
  /// 输入框控制器
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /// 焦点透明度
  final RxDouble _opacity = 1.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;

  /// 验证码数组
  final RxList _codeList = [].obs;
  set codeList(List value) => _codeList.value = value;
  List get codeList => _codeList;

  /// 发送时间
  final RxInt _sendTime = 0.obs;
  set sendTime(int value) => _sendTime.value = value;
  int get sendTime => _sendTime.value;

  /// 动画结束后继续动画
  void handleOnEnd() {
    opacity = opacity == 0 ? 1.0 : 0.0;
  }

  /// 点击六个格子的时候，弹出键盘
  void handleOnPressed() {
    focusNode.requestFocus();
  }

  void onChanged(text) {}

  void resendCode() {}
}

Widget getVerifyView() {
  return GetBuilder<VerifyWidgetController>(
    init: VerifyWidgetController(),
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
          onChanged: controller.onChanged,
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
              color: controller.codeList.length >= index
                  ? AppColors.mainColor
                  : AppColors.thirdIcon,
              width: 0.8.w,
            ),
          ),
          child: Center(
            child: controller.codeList.length == index
                ? AnimatedOpacity(
                    opacity: controller.opacity,
                    duration: const Duration(milliseconds: 500),
                    alwaysIncludeSemantics: true,
                    onEnd: controller.handleOnEnd,
                    child: Container(
                        width: 1.w, height: 10.w, color: AppColors.mainColor),
                  )
                : controller.codeList.length < index
                    ? null
                    : getSpan(
                        controller.codeList[index],
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
      Widget resendButton = Obx(
        () => getButton(
          child: controller.sendTime <= 0
              ? getSpan(Lang.codeResend.tr, color: AppColors.mainColor)
              : getSpan(
                  '${Lang.codeResend.tr} ( ${controller.sendTime} )',
                  color: AppColors.secondText,
                ),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          background: Colors.transparent,
          onPressed: controller.sendTime <= 0 ? controller.resendCode : null,
        ),
      );

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
