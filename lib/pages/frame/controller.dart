import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/frame/state.dart';
import 'package:pinker/pages/frame/verify/index.dart';
import 'package:pinker/routes/app_pages.dart';
import 'index/index.dart';
import 'login/index.dart';
import 'register/index.dart';

class FrameController extends GetxController {
  final state = FrameState();

  /// 返回上一页
  void handleBack() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 200));
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
    );
  }

  /// 嵌套路由设置
  Route? onGenerateRoute(RouteSettings settings) {
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
      Get.routing.args = settings.arguments;
      return _getPageRoute(
        page: const VerifyView(),
        settings: settings,
        binding: VerifyBinding(),
      );
    }
    return null;
  }
}
