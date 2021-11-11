import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/user_info.dart';
import 'package:pinker/pages/fogot/index/library.dart';

import 'package:pinker/pages/fogot/library.dart';

class ForgotController extends GetxController {
  /// 状态控制器
  final ForgotState state = ForgotState();

  /// 页面控制器
  final PageController pageController = PageController();

  /// 关闭页面
  void handleBack() {
    Get.back();
  }

  /// 初始化用户数据
  UserInfo userInfo = UserInfo.fromJson({
    'userId': 0,
    'userName': '',
    'nickName': '',
    'avatar': '',
    'phone': '',
    'email': '',
  });

  /// 初始化验证码请求数据
  Map<String, dynamic> publicData = {};

  @override
  void onInit() async {
    super.onInit();
    state.pageCount.add(const ForgotIndexView());
    interval(state.sendTimeRx, (value) {
      if (state.sendTime > 0) state.sendTime--;
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
