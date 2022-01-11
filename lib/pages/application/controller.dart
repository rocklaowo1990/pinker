import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/library.dart';

import 'package:pinker/utils/utils.dart';

class ApplicationController extends GetxController {
  /// 响应式成员
  final ApplicationState state = ApplicationState();
  final pageController = PageController();

  void handlePageChanged(index) {
    state.pageIndex = index;
  }

  // /// 嵌套路由封装
  // GetPageRoute _getPageRoute({
  //   required RouteSettings settings,
  //   required Widget page,
  //   Bindings? binding,
  // }) {
  //   return GetPageRoute(
  //     settings: settings,
  //     page: () => page,
  //     transition: Transition.noTransition,
  //     // transitionDuration: const Duration(milliseconds: 200),
  //     binding: binding,
  //   );
  // }

  // /// 嵌套路由设置
  // Route? onGenerateRoute(RouteSettings settings) {
  //   Get.routing.args = settings.arguments;
  //   if (settings.name == AppRoutes.home) {
  //     return _getPageRoute(
  //       page: const HomeView(),
  //       settings: settings,
  //       binding: HomeBinding(),
  //     );
  //   } else if (settings.name == AppRoutes.community) {
  //     return _getPageRoute(
  //       page: const CommunityView(),
  //       settings: settings,
  //       binding: CommunityBinding(),
  //     );
  //   } else if (settings.name == AppRoutes.chat) {
  //     return _getPageRoute(
  //       page: const ChatView(),
  //       settings: settings,
  //       binding: ChatBinding(),
  //     );
  //   } else if (settings.name == AppRoutes.my) {
  //     return _getPageRoute(
  //       page: const MyView(),
  //       settings: settings,
  //       binding: MyBinding(),
  //     );
  //   }
  //   return null;
  // }

  /// 页面加载时
  @override
  void onReady() async {
    super.onReady();

    await getUserInfo();

    // interval(
    //   state.rxInt,
    //   (int value) {
    //     state.pageIndex = value;
    //     if (state.pageIndex == 0) Get.offAllNamed(AppRoutes.home, id: 2);
    //     if (state.pageIndex == 1) Get.offAllNamed(AppRoutes.community, id: 2);
    //     if (state.pageIndex == 2) Get.offAllNamed(AppRoutes.chat, id: 2);
    //     if (state.pageIndex == 3) Get.offAllNamed(AppRoutes.my, id: 2);
    //   },
    //   time: const Duration(milliseconds: 100),
    // );
  }
}
