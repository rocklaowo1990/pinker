import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinker/pages/index/index.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logo = Icon(
      IconFont.logo,
      size: 24.w,
      color: AppColors.main,
    );

    var text = Text(
      '查看世界正在发生的新鲜事情',
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        foreground: Paint()..shader = AppColors.linearGradientText,
      ),
    );

    var signUpButton = buttonWidget(
      onPressed: controller.handleSignIn,
      text: '创建账号',
    );

    var signInbutton = SizedBox(
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          text: '已有账号了？',
          style: TextStyle(fontSize: 8.sp, color: AppColors.darkText),
          children: [
            TextSpan(
              text: ' 去登陆',
              style: TextStyle(fontSize: 8.sp, color: AppColors.main),
              recognizer: TapGestureRecognizer()
                ..onTap = controller.handleSignUp,
            ),
          ],
        ),
      ),
    );

    var body = Container(
      padding: EdgeInsets.only(
        top: 27.5.h,
        right: 20.w,
        bottom: 27.5.h,
        left: 20.w,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.linearGradientContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          logo,
          Column(
            children: [
              text,
              SizedBox(height: 10.h),
              signUpButton,
            ],
          ),
          signInbutton,
        ],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
