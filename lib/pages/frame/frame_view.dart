import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class FrameView extends GetView<FrameController> {
  const FrameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// logo
    Widget logo = Icon(
      IconFont.logo,
      size: 18.w,
      color: AppColors.mainColor,
    );

    /// appBar 两侧的占位
    Widget emptyBox = const SizedBox();

    /// appBar 左侧的返回按钮
    Widget buttonBox = getButton(
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 9.w,
        color: AppColors.mainIcon,
      ),
      onPressed: controller.handleBack,
      background: Colors.transparent,
    );

    /// appBar 右侧的设置按钮
    Widget settingBox = getButton(
      child: Icon(
        Icons.settings,
        size: 10.w,
        color: AppColors.mainIcon,
      ),
      onPressed: controller.handleGoSettingView,
      background: Colors.transparent,
      width: 30.w,
      height: 40.w,
    );

    /// appBar
    AppBar appBar = getAppBar(
      title: logo,
      leading: Obx(() => controller.isShow.value ? buttonBox : emptyBox),
      actions: [settingBox],
    );

    /// body 嵌套路由
    Widget body = Navigator(
      key: Get.nestedKey(1),
      initialRoute: controller.pages[0],
      onGenerateRoute: controller.onGenerateRoute,
    );

    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
