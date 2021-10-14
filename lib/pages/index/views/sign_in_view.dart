import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/index/index.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SignInView extends GetView<IndexController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = span(text: '登陆 Pinker', size: 16.sp);
    var userCount = input(
      type: InputType.count,
      controller: controller.userCountController,
    );
    var userPassword = input(
      type: InputType.password,
      controller: controller.userPasswordController,
    );

    var body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 30.h,
            right: 20.w,
            left: 20.w,
          ),
          child: Column(
            children: [
              title,
              SizedBox(height: 30.h),
              userCount,
              // GetX<IndexController>(
              //   builder: (builder) {
              //     return userCount;
              //   },
              //   init: controller,
              //   initState: (builder) {},
              // ),

              // SizedBox(
              //   height: 50.h,
              //   child: Obx(() => userCount),
              // ),

              SizedBox(height: 6.h),
              userPassword,
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 24.5.h,
          color: AppColors.white,
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: body,
    );
  }
}
