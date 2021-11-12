import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/fogot/index/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotIndexView extends GetView<ForgotIndexController> {
  const ForgotIndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getSpan('找到您的账号', fontSize: 26);

    /// 账号输入框
    Widget userCount = getInput(
      type: Lang.inputCount.tr,
      controller: controller.textController,
      autofocus: true,
      focusNode: controller.focusNode,
      textInputAction: TextInputAction.next,
    );

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: Obx(
        () => getButton(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
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
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              title,
              SizedBox(height: 16.w),
              userCount,
            ],
          ),
        ),
        bottom,
      ],
    );
    return Obx(() => controller.forgotController.state.pageIndex != 0
        ? Stack(
            // 遮罩层
            children: [body, Container(color: Colors.black12)],
          )
        : body);
  }
}
