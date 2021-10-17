import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    var logo = Icon(
      IconFont.logo,
      size: 18.w,
      color: AppColors.mainColor,
    );

    /// appBar 两侧的占位
    var emptyBox = const SizedBox();

    /// 按钮函数
    Widget _buttonBox({
      required IconData icon,
      required VoidCallback onPressed,
      double? size,
    }) {
      return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppColors.mainText,
          size: size ?? 8.5.w,
        ),
      );
    }

    /// appBar 左侧的返回按钮
    var buttonBox = _buttonBox(
      icon: Icons.arrow_back_ios_new,
      size: 9.w,
      onPressed: controller.handleGoSignBeforePage,
    );

    /// appBar 右侧的设置按钮
    var settingBox = _buttonBox(
      icon: Icons.settings,
      size: 10.w,
      onPressed: () {},
    );

    /// appBar
    var appBar = AppBar(
      title: logo,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      leading: Obx(() => controller.isShow.value ? buttonBox : emptyBox),
      actions: [
        settingBox,
        SizedBox(width: 3.w),
      ],
    );

    /// body 嵌套路由
    var body = Navigator(
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
