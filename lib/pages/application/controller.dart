import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/chat/library.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/routes/app_pages.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ApplicationController extends GetxController {
  /// 响应式成员
  final ApplicationState state = ApplicationState();

  /// 底部导航子组件
  Widget bottomChild(int index) {
    Widget _child(IconData icon) {
      return Obx(
        () => Icon(
          icon,
          color: state.pageIndex == index
              ? AppColors.mainColor
              : AppColors.secondIcon,
        ),
      );
    }

    Widget child = _child(Icons.home);

    switch (index) {
      case 0:
        child = _child(Icons.home);
        break;
      case 1:
        child = _child(Icons.public);

        break;
      case 2:
        child = _child(Icons.sms);

        break;
      case 3:
        child = _child(Icons.person);
        break;

      default:
    }
    return getButton(
      child: child,
      width: 32.h,
      height: 32.h,
      background: Colors.transparent,
      onPressed: () {
        if (state.rxIntValue != index) state.rxIntValue = index;
      },
    );
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
      transition: Transition.noTransition,
      // transitionDuration: const Duration(milliseconds: 200),
      binding: binding,
    );
  }

  /// 嵌套路由设置
  Route? onGenerateRoute(RouteSettings settings) {
    Get.routing.args = settings.arguments;
    if (settings.name == AppRoutes.home) {
      return _getPageRoute(
        page: const HomeView(),
        settings: settings,
        binding: HomeBinding(),
      );
    } else if (settings.name == AppRoutes.community) {
      return _getPageRoute(
        page: const CommunityView(),
        settings: settings,
        binding: CommunityBinding(),
      );
    } else if (settings.name == AppRoutes.chat) {
      return _getPageRoute(
        page: const ChatView(),
        settings: settings,
        binding: ChatBinding(),
      );
    } else if (settings.name == AppRoutes.my) {
      return _getPageRoute(
        page: const MyView(),
        settings: settings,
        binding: MyBinding(),
      );
    }
    return null;
  }

  /// 页面加载时
  @override
  void onReady() {
    super.onReady();

    interval(
      state.rxInt,
      (int value) {
        state.pageIndex = value;
        if (state.pageIndex == 0) Get.offAllNamed(AppRoutes.home, id: 2);
        if (state.pageIndex == 1) Get.offAllNamed(AppRoutes.community, id: 2);
        if (state.pageIndex == 2) Get.offAllNamed(AppRoutes.chat, id: 2);
        if (state.pageIndex == 3) Get.offAllNamed(AppRoutes.my, id: 2);
      },
      time: const Duration(milliseconds: 100),
    );
  }
}
