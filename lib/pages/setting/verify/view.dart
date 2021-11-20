import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/setting/verify/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetVerifyView extends GetView<SetVerifyController> {
  const SetVerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('验证码', fontSize: 17),
      backgroundColor: AppColors.mainBacground,
      elevation: 0.5.h,
    );

    /// body 布局
    Widget body = getVerifyView(
      isVerify: controller.isVerify,
      result: controller.next,
      resendCode: controller.sendCode,
      time: controller.settingController.state.sendTimeRx,
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.mainBacground,
      body: body,
    );
  }
}
