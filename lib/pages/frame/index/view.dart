import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/index/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget text = getIndexTitle(Lang.indexTitle.tr);

    /// 去注册页面的按钮
    Widget signUpButton = getButtonMain(
      onPressed: controller.handleGoSignUpPage,
      child: getSpan(Lang.indexGoRegister.tr),
    );

    /// 去登陆页面的按钮
    Widget signInbutton = SizedBox(
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          text: Lang.indexHint.tr,
          style: secondStyle,
          children: [
            TextSpan(
              text: Lang.indexGoLogin.tr,
              style: mainStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = controller.handleGoSignInPage,
            ),
          ],
        ),
      ),
    );

    /// body 布局
    Widget body = Padding(
      padding: EdgeInsets.only(
        right: 32.w,
        bottom: 64.h,
        left: 32.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(),
          Column(
            children: [
              text,
              SizedBox(height: 20.h),
              signUpButton,
            ],
          ),
          signInbutton,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != 0
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
