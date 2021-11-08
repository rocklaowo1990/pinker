import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/fogot/index/library.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotIndexView extends StatelessWidget {
  ForgotIndexView({Key? key}) : super(key: key);
  final ForgotIndexController controller = ForgotIndexController();

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getSpan(Lang.loginTitle.tr, fontSize: 26);

    /// 账号输入框
    Widget userCount = getInput(
      type: Lang.inputCount.tr,
      controller: controller.textController,
      autofocus: true,
      focusNode: controller.focusNode,
      textInputAction: TextInputAction.next,
    );

    /// body布局
    Widget body = Column(
      children: [
        title,
        SizedBox(height: 30.h),
        userCount,
      ],
    );
    return body;
  }

  @override
  StatelessElement createElement() {
    controller.init();
    return super.createElement();
  }
}
