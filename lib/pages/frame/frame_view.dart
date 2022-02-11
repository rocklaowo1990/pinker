import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/routes/routes.dart';
import 'package:pinker/store/user.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class FrameView extends GetView<FrameController> {
  const FrameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenInit(context);

    /// appBar 两侧的占位
    Widget emptyBox = const SizedBox();

    /// appBar
    AppBar appBar = getAppBar(
      getLogoIcon(),
      leading: Obx(() => controller.state.pageIndex > 0
          ? getBackButton(onPressed: controller.handleBack)
          : emptyBox),
      actions: [
        getSettingButton(onPressed: controller.handleGoSettingView),
      ],
    );

    /// body 嵌套路由
    Widget body = Navigator(
      key: Get.nestedKey(1),
      initialRoute: AppRoutes.index,
      onGenerateRoute: controller.onGenerateRoute,
    );

    return UserStore.to.isOfflineLogin
        ? const ApplicationView()
        : Scaffold(
            backgroundColor: AppColors.mainBacground,
            appBar: appBar,
            body: body,
          );
  }
}
