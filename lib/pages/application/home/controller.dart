import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/routes/app_pages.dart';

import 'package:pinker/utils/utils.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomeState state = HomeState();

  final ApplicationController applicationController = Get.find();
  final scrollController = ScrollController();

  void handleMail() {}

  void handSubscribeinfo(item) async {
    applicationController.state.recommendUserList.update((val) {
      val!.list.remove(item);
    });

    await getContentListAll();

    if (applicationController.state.recommendUserList.value.list.length <= 4) {
      await getRecommendList(pageNo: 1);
    }
  }

  void handleRemmondMore() {
    Get.toNamed(AppRoutes.recommendUserList);
  }

  @override
  void onReady() async {
    super.onReady();
    await getHomeData();
    await getRecommendList(pageNo: 1);
  }

  void handlePersonal() {
    Get.toNamed(
      AppRoutes.personal,
      arguments: applicationController.state.userInfo.value.userId,
    );
  }
}
