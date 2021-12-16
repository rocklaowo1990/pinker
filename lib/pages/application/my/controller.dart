import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/routes/app_pages.dart';

class MyController extends GetxController {
  final MyState state = MyState();
  final ScrollController scrollController = ScrollController();

  final ApplicationController applicationController = Get.find();

  void handleMail() {
    Get.toNamed(AppRoutes.set);
  }

  void handleSetting() {
    Get.toNamed(AppRoutes.set, arguments: applicationController);
  }

  @override
  void onReady() async {
    super.onReady();

    scrollController.addListener(() {
      state.opacity = scrollController.offset / 100;
      if (state.opacity > 1) state.opacity = 1;
      if (state.opacity < 0) state.opacity = 0;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    applicationController.dispose();
    super.dispose();
  }
}
