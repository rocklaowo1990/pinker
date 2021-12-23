import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/community/hot/library.dart';

import 'package:pinker/pages/application/community/library.dart';

import 'package:pinker/pages/application/community/new/library.dart';

import 'package:pinker/routes/app_pages.dart';

class CommunityController extends GetxController {
  /// 响应式成员
  final CommunityState state = CommunityState();

  /// 页面控制器
  final ExtendedPageController pageController = ExtendedPageController();

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
      // popGesture: true,
    );
  }

  /// 嵌套路由设置
  Route? onGenerateRoute(RouteSettings settings) {
    Get.routing.args = settings.arguments;
    if (settings.name == AppRoutes.contentNew) {
      return _getPageRoute(
        page: const ContentListNewView(),
        settings: settings,
        binding: ContentListNewBinding(),
      );
    } else if (settings.name == AppRoutes.contentHot) {
      return _getPageRoute(
        page: const ContentListHotView(),
        settings: settings,
        binding: ContentListHotBinding(),
      );
    }
    return null;
  }

  void handleChangedTab(index) {
    state.pageIndex = index;
    // pageController.animateToPage(
    //   state.pageIndex,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.ease,
    // );
    index == 0 ? Get.back(id: 3) : Get.toNamed(AppRoutes.contentHot, id: 3);
  }

  void handlePageChanged(index) {
    state.pageIndex = index;
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }
}
