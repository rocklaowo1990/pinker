import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/fogot/index/library.dart';
import 'package:pinker/pages/fogot/info/library.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/password/library.dart';
import 'package:pinker/pages/fogot/type/library.dart';
import 'package:pinker/pages/fogot/verify/library.dart';
import 'package:pinker/routes/routes.dart';


class ForgotController extends GetxController {
  ForgotController(this.arguments);

  /// 状态控制器
  final ForgotState state = ForgotState();

  final String? arguments;

  /// 关闭页面
  void handleBack() {
    Get.back();
  }

  ForgotInfoEntities forgotInfo = ForgotInfoEntities.fromJson({
    'userId': 0,
    'userName': '',
    'nickName': '',
    'avatar': '',
    'phone': '',
    'email': '',
  });

  /// 初始化验证码请求数据
  Map<String, dynamic> publicData = {};

  /// 嵌套路由封装
  GetPageRoute _getPageRoute({
    required RouteSettings settings,
    required Widget page,
    Bindings? binding,
  }) {
    return GetPageRoute(
      settings: settings,
      page: () => page,
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      binding: binding,
    );
  }

  /// 嵌套路由设置
  Route? onGenerateRoute(RouteSettings settings) {
    Get.routing.args = settings.arguments;
    if (settings.name == AppRoutes.forgotIndex) {
      return _getPageRoute(
        page: const ForgotIndexView(),
        settings: settings,
        binding: ForgotIndexBinding(),
      );
    } else if (settings.name == AppRoutes.forgotInfo) {
      return _getPageRoute(
        page: const ForgotInfoView(),
        settings: settings,
        binding: ForgotInfoBinding(),
      );
    } else if (settings.name == AppRoutes.forgotPassword) {
      return _getPageRoute(
        page: const ForgotPasswordView(),
        settings: settings,
        binding: ForgotPasswordBinding(),
      );
    } else if (settings.name == AppRoutes.forgotType) {
      return _getPageRoute(
        page: const ForgotTypeView(),
        settings: settings,
        binding: ForgotTypeBinding(),
      );
    } else if (settings.name == AppRoutes.forgotVerify) {
      return _getPageRoute(
        page: const ForgotVerifyView(),
        settings: settings,
        binding: ForgotVerifyBinding(),
      );
    }
    return null;
  }

  @override
  void onInit() async {
    if (arguments != null) {
      final ApplicationController applicationController = Get.find();
      forgotInfo.userId = applicationController.state.userInfo.value.userId;
      forgotInfo.phone = applicationController.state.userInfo.value.phone;
      if (forgotInfo.phone == '') {
        forgotInfo.email = applicationController.state.userInfo.value.email;
        state.verifyType = 2;
      }
      forgotInfo.nickName = applicationController.state.userInfo.value.nickName;
      forgotInfo.avatar = applicationController.state.userInfo.value.avatar;
      forgotInfo.userName = applicationController.state.userInfo.value.userName;
      state.pageIndex = 2;
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    interval(state.sendTimeRx, (value) {
      if (state.sendTime > 0) state.sendTime--;
    });
  }
}
