import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/subscription/library.dart';

import 'package:pinker/values/colors.dart';
import 'package:pinker/widgets/widgets.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题部分组合
    Widget top = Column(
      children: [
        getSpan('推荐订阅', size: 16.sp),
        SizedBox(height: 8.h),
        getSpan(
          '当你关注某人后，你会在自己的主页看到他们的推文',
          color: AppColors.secondText,
          textAlign: TextAlign.center,
        ),
      ],
    );

    Widget middle = Container(
      color: AppColors.mainColor,
      width: double.infinity,
      height: 2000.h,
    );

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: getButton(
        width: 40.w,
        height: 18.h,
        child: getSpan(Lang.next.tr),
        onPressed: controller.handleNext,
      ),
    );

    /// body 布局
    Widget body = Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8.h),
                top,
                SizedBox(height: 16.h),
                middle,
              ],
            ),
          ),
        ),
        bottom,
      ],
    );

    /// 布局
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != -3
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
