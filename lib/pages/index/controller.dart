import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/index/index.dart';

class IndexController extends GetxController {
  static IndexController get to => Get.find();
  final pages = <String>['/signBefore', '/signIn', '/signUp'];

  /// 登陆按钮
  void handleSignIn() {
    Get.toNamed(pages[1], id: 1);
  }

  /// 注册按钮
  void handleSignUp() {
    Get.toNamed(pages[2], id: 1);
  }

  GetPageRoute _getPageRoute({
    required RouteSettings settings,
    required Widget page,
  }) {
    return GetPageRoute(
      settings: settings,
      page: () => page,
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/signBefore') {
      return _getPageRoute(
        page: const SignBeforeView(),
        settings: settings,
      );
    } else if (settings.name == '/signIn') {
      return _getPageRoute(
        page: const SignInView(),
        settings: settings,
      );
    } else if (settings.name == '/signUp') {
      return _getPageRoute(
        page: const SignUpView(),
        settings: settings,
      );
    }

    return null;
  }
}
