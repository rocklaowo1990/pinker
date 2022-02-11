import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/frame/avatar/library.dart';
import 'package:pinker/pages/frame/password/library.dart';
import 'package:pinker/pages/frame/state.dart';
import 'package:pinker/pages/frame/subscription/library.dart';
import 'package:pinker/pages/frame/verify/library.dart';

import 'package:pinker/routes/routes.dart';
import 'index/library.dart';
import 'login/library.dart';
import 'register/library.dart';

class FrameController extends GetxController {
  final state = FrameState();

  /// 返回上一页
  void handleBack() {
    state.pageIndex--;
    Get.back(id: 1);
  }

  /// 去设置页面
  void handleGoSettingView() async {
    Get.toNamed(AppRoutes.set);
  }

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
      popGesture: false,
    );
  }

  /// 嵌套路由设置
  Route? onGenerateRoute(RouteSettings settings) {
    Get.routing.args = settings.arguments;
    if (settings.name == AppRoutes.index) {
      return _getPageRoute(
        page: const IndexView(),
        settings: settings,
        binding: IndexBinding(),
      );
    } else if (settings.name == AppRoutes.login) {
      return _getPageRoute(
        page: const LoginView(),
        settings: settings,
        binding: LoginBinding(),
      );
    } else if (settings.name == AppRoutes.register) {
      return _getPageRoute(
        page: const RegisterView(),
        settings: settings,
        binding: RegisterBinding(),
      );
    } else if (settings.name == AppRoutes.verify) {
      return _getPageRoute(
        page: const VerifyView(),
        settings: settings,
        binding: VerifyBinding(),
      );
    } else if (settings.name == AppRoutes.password) {
      return _getPageRoute(
        page: const PasswordView(),
        settings: settings,
        binding: PasswordBinding(),
      );
    } else if (settings.name == AppRoutes.avatar) {
      return _getPageRoute(
        page: const AvatarView(),
        settings: settings,
        binding: AvatarBinding(),
      );
    } else if (settings.name == AppRoutes.subscription) {
      return _getPageRoute(
        page: const SubscriptionView(),
        settings: settings,
        binding: SubscriptionBinding(),
      );
    }
    return null;
  }

  @override
  void onReady() {
    super.onReady();
    interval(state.sendTimeRx, (value) {
      if (state.sendTime > 0) state.sendTime--;
    });
  }
}
