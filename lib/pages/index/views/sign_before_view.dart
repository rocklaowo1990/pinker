import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/index/index.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SignBeforeView extends GetView<IndexController> {
  const SignBeforeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = Text(
      '查看世界正在发生的新鲜事情',
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        foreground: Paint()..shader = AppColors.linearGradientText,
      ),
    );

    var signUpButton = buttonWidget(
      onPressed: controller.handleGoSignUpPage,
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
                ..onTap = controller.handleGoSignInPage,
            ),
          ],
        ),
      ),
    );

    var body = Padding(
      padding: EdgeInsets.only(
        right: 20.w,
        bottom: 30.h,
        left: 20.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(),
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
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: controller.isMax.value
            ? Stack(
                children: [
                  body,
                  Container(
                    color: Colors.black12,
                  )
                ],
              )
            : body,
      );
    });
  }
}
