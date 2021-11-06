import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/widgets/widgets.dart';

Widget forgotOne(controller) {
  /// 标题
  Widget title = getSpan('找到您的账号', fontSize: 26);

  /// 账号输入框
  Widget userPassword = getInput(
    type: Lang.inputCount.tr,
    controller: controller.textController,
    focusNode: controller.focusNode,
    autofocus: true,
  );
  return Column(
    children: [
      title,
      SizedBox(height: 20.h),
      userPassword,
    ],
  );
}
