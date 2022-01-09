import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/wallet.dart';
import 'package:pinker/entities/response.dart';

import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyController extends GetxController {
  final MyState state = MyState();
  final ScrollController scrollController = ScrollController();

  final ApplicationController applicationController = Get.find();

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await futureMill(1000);

    refreshController.refreshCompleted();
  }

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
      if (scrollController.offset >= 50) state.opacity = 1;
      if (scrollController.offset < 50) state.opacity = 0;
    });
  }

  void handleDiamond() async {
    getDialog();
    await futureMill(500);
    ResponseEntity responseEntity = await WalletApi.testAddMoney(type: 1);

    if (responseEntity.code == 200) {
      await futureMill(500);
      Get.back();
      getSnackTop('充值成功', isError: false);
      getUserInfo(applicationController.state.userInfo);
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  void handleP() async {
    getDialog();
    await futureMill(500);

    ResponseEntity responseEntity = await WalletApi.testAddMoney(type: 2);
    if (responseEntity.code == 200) {
      await futureMill(500);
      Get.back();
      getSnackTop('充值成功', isError: false);
      getUserInfo(applicationController.state.userInfo);
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    applicationController.dispose();
    refreshController.dispose();
    super.dispose();
  }
}
