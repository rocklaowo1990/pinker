import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/frame/index/index.dart';
import 'package:pinker/pages/frame/login/index.dart';
import 'package:pinker/pages/frame/register/index.dart';

class FrameController extends GetxController {
  /// 嵌套路由路径
  final pages = <String>['/index', '/login', '/register'];

  /// 控制蒙版是否显示
  RxBool isShow = false.obs;

  /// 返回默认页面按钮
  void handleBack() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 200));
    isShow.value = false;
    Get.back(id: 1);
  }

  /// 去设置页面
  void handleGoSettingView() {
    Get.toNamed('/set');
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
    if (settings.name == pages[0]) {
      return _getPageRoute(
        page: const IndexView(),
        settings: settings,
        binding: IndexBinding(),
      );
    } else if (settings.name == pages[1]) {
      return _getPageRoute(
        page: const LoginView(),
        settings: settings,
        binding: LoginBinding(),
      );
    } else if (settings.name == pages[2]) {
      return _getPageRoute(
        page: const RegisterView(),
        settings: settings,
        binding: RegisterBinding(),
      );
    }
    return null;
  }
}
