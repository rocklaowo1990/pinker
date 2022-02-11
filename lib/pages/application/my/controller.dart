import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/wallet.dart';
import 'package:pinker/entities/response.dart';

import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/application/my/library.dart';

import 'package:pinker/routes/routes.dart';
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

  void handleSubscribeList() {
    Get.toNamed(AppRoutes.subscribeList);
  }

  void handleSetting() {
    Get.toNamed(AppRoutes.set, arguments: applicationController);
  }

  void handlePersonal() {
    Get.toNamed(
      AppRoutes.personal,
      arguments: applicationController.state.userInfo.value.userId,
    );
  }

  @override
  void onReady() async {
    super.onReady();

    scrollController.addListener(() {
      if (scrollController.offset >= 50) state.opacity = 1;
      if (scrollController.offset < 50) state.opacity = 0;
    });
  }

  void _sureDiamond() async {
    Get.back();
    getDialog();

    ResponseEntity responseEntity = await WalletApi.testAddMoney(type: 1);

    if (responseEntity.code == 200) {
      await futureMill(500);
      Get.back();

      getUserInfo();
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  void handleDiamond() async {
    getDialog(
      child: DialogChild.alert(
        title: '测试充值',
        content: '继续操作将充值 1000 钻石',
        onPressedRight: _sureDiamond,
        leftText: '取消',
        onPressedLeft: () {
          Get.back();
        },
      ),
      autoBack: true,
    );
  }

  void _sureP() async {
    Get.back();
    getDialog();

    ResponseEntity responseEntity = await WalletApi.testAddMoney(type: 2);
    if (responseEntity.code == 200) {
      await futureMill(500);
      Get.back();

      getUserInfo();
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  void handleP() async {
    getDialog(
      child: DialogChild.alert(
        title: '测试充值',
        content: '继续操作将充值 1000 P',
        onPressedRight: _sureP,
        leftText: '取消',
        onPressedLeft: () {
          Get.back();
        },
      ),
      autoBack: true,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    applicationController.dispose();
    refreshController.dispose();
    super.dispose();
  }
}
