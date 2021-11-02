import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/chat/library.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/home/library.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/values/values.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 底部导航
    Widget bottomNavigationBar = Container(
      width: double.infinity,
      height: 32.h,
      padding: EdgeInsets.only(left: 7.w, right: 7.w),
      decoration: BoxDecoration(
        color: AppColors.secondBacground,
        border: Border(
          top: BorderSide(width: 0.5.w, color: AppColors.line),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          controller.bottomChild(0),
          controller.bottomChild(1),
          controller.bottomChild(2),
          controller.bottomChild(3),
        ],
      ),
    );

    /// body
    Widget body = PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        HomeView(),
        CommunityView(),
        ChatView(),
        MyView(),
      ],
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
