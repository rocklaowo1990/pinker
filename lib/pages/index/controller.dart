import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/index/index.dart';

class IndexController extends GetxController {
  final pages = <String>['/signBefore', '/signIn', '/signUp'];

  final TextEditingController userCountController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  /// 去登陆页面按钮
  void handleGoSignInPage() async {
    Get.toNamed(pages[1], id: 1);
  }

  /// 去注册页面按钮
  void handleGoSignUpPage() {
    Get.toNamed(pages[2], id: 1);
  }

  /// 返回默认页面按钮
  void handleGoSignBeforePage() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 200));
    Get.back(id: 1);
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

  @override
  void dispose() {
    userCountController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }
}
