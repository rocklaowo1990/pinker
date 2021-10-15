import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinker/pages/index/index.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// logo
    var logo = Icon(
      IconFont.logo,
      size: 18.w,
      color: AppColors.main,
    );

    /// appBar 两侧的占位
    var emptyBox = SizedBox(
      width: 48.h - 16.h,
      height: 48.h - 16.h,
    );

    /// appBar 左侧的返回按钮
    var buttonBox = SizedBox(
      width: 48.h - 16.h,
      height: 48.h - 16.h,
      child: IconButton(
        onPressed: controller.handleGoSignBeforePage,
        icon: Icon(
          IconFont.back,
          color: AppColors.white,
          size: 8.5.w,
        ),
      ),
    );

    /// appBar 布局
    var appBar = Obx(
      () => Container(
        padding: EdgeInsets.only(top: 16.h),
        width: double.infinity,
        height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            controller.isShow.value ? buttonBox : emptyBox,
            logo,
            emptyBox,
          ],
        ),
      ),
    );

    /// body 嵌套路由
    var body = Navigator(
      key: Get.nestedKey(1),
      initialRoute: '/signBefore',
      onGenerateRoute: controller.onGenerateRoute,
    );

    /// 页面组成
    var scaffold = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.linearGradientContainer, // 渐变背景
      ),
      child: Column(
        children: [
          appBar,
          Expanded(
            child: body, // 自适应body高度
            flex: 1,
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: scaffold,
    );
  }
}
