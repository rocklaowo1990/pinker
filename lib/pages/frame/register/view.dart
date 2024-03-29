import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/register/controller.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getTitle(Lang.registerTitle.tr);

    /// 账号输入框
    Widget userRegister = Obx(() => getInput(
          type: controller.state.isPhone
              ? Lang.inputPhone.tr
              : Lang.inputEmail.tr,
          controller: controller.textController,
          focusNode: controller.focusNode,
          prefixIcon: controller.state.isPhone
              ? getButton(
                  child: getSpanMain('+${controller.state.code}'),
                  background: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  onPressed: controller.handleGoCodeList,
                )
              : null,
        ));

    /// 生日输入框
    Widget userBirth = Obx(
      () => getButton(
        height: 48,
        padding: const EdgeInsets.only(left: 20),
        onPressed: controller.birthChoice,
        child: getSpan(
            '${controller.state.showTime.year}-${controller.state.showTime.month}-${controller.state.showTime.day}'),
        alignment: Alignment.centerLeft,
        background: AppColors.inputFiled,
        width: Get.width,
      ),
    );

    // // 服务条款 和 隐私政策富文本
    // Widget richText = RichText(
    //   text: TextSpan(
    //     text: Lang.registerAgreen_1.tr,
    //     style: secondStyle,
    //     children: [
    //       TextSpan(
    //         text: Lang.registerService.tr,
    //         style: mainStyle,
    //         recognizer: TapGestureRecognizer()
    //           ..onTap = controller.handleGoService,
    //       ),
    //       TextSpan(text: Lang.registerAgreen_2.tr, style: secondStyle),
    //       TextSpan(
    //         text: Lang.registerPrivacy.tr,
    //         style: mainStyle,
    //         recognizer: TapGestureRecognizer()
    //           ..onTap = controller.handleGoPrivacy,
    //       ),
    //     ],
    //   ),
    // );

    // /// 同意服务条款
    // Widget agreen = getButton(
    //   overlayColor: Colors.transparent,
    //   onPressed: controller.handleAgreen,
    //   width: double.infinity,
    //   alignment: Alignment.centerLeft,
    //   background: Colors.transparent,
    //   child: Row(
    //     children: [
    //       Obx(() => getCheckIcon(isChooise: controller.state.isChooise)),
    //       SizedBox(width: 8),
    //       getButton(
    //           child: richText,
    //           height: 20,
    //           onPressed: () {
    //             print('object');
    //           })
    //     ],
    //   ),
    // );

    Widget agreen = SizedBox(
      width: double.infinity,
      child: Wrap(
        runSpacing: 8,
        children: [
          getButtonTransparent(
            child:
                Obx(() => getCheckIcon(isChooise: controller.state.isChooise)),
            onPressed: controller.handleAgreen,
          ),
          const SizedBox(width: 10),
          getButtonTransparent(
            child: getSpanSecond(Lang.registerAgreen_1.tr),
            onPressed: controller.handleAgreen,
          ),
          getButtonTransparent(
            child: getSpanMain(
              Lang.registerService.tr,
            ),
            onPressed: () {},
          ),
          getButtonTransparent(
            child: getSpanSecond(Lang.registerAgreen_2.tr),
            onPressed: controller.handleAgreen,
          ),
          getButtonTransparent(
            child: getSpanMain(Lang.registerPrivacy.tr),
            onPressed: () {},
          ),
        ],
      ),
    );

    /// 底部
    Widget bottom = getBottomBox(
      leftWidget: getButton(
        child: Obx(
          () => getSpan(
            controller.state.isPhone
                ? Lang.registerPhone.tr
                : Lang.registerEmail.tr,
            color: AppColors.mainColor,
          ),
        ),
        onPressed: controller.handleChangeRegister,
        background: Colors.transparent,
      ),
      rightWidget: Obx(
        () => getButtonSheet(
          child: getSpan(Lang.next.tr),
          onPressed:
              !controller.state.isAccountPass && controller.state.isChooise
                  ? controller.handleNext
                  : null,
          background:
              !controller.state.isAccountPass && controller.state.isChooise
                  ? AppColors.mainColor
                  : AppColors.buttonDisable,
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
              padding: const EdgeInsets.only(
                top: 24,
                right: 20,
                left: 20,
              ),
              child: Column(
                children: [
                  title,
                  const SizedBox(height: 30),
                  userRegister,
                  const SizedBox(height: 4),
                  userBirth,
                  const SizedBox(height: 16),
                  agreen,
                ],
              ),
            ),
          ),
        ),
        bottom,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != 1
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
