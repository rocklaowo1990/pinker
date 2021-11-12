import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/user_info.dart';
import 'package:pinker/pages/fogot/index/library.dart';
import 'package:pinker/pages/fogot/info/library.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/password/library.dart';
import 'package:pinker/pages/fogot/type/library.dart';
import 'package:pinker/pages/fogot/verify/library.dart';
import 'package:pinker/routes/app_pages.dart';

class ForgotController extends GetxController {
  /// 状态控制器
  final ForgotState state = ForgotState();

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
    super.onInit();
    state.pageCount.add(const ForgotIndexView());
    interval(state.sendTimeRx, (value) {
      if (state.sendTime > 0) state.sendTime--;
    });
  }
}
