import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pinker/pages/application/community/library.dart';

class CommunityController extends GetxController {
  /// 响应式成员
  final CommunityState state = CommunityState();

  /// 页面控制器
  final PageController pageController = PageController();

  void handleChangedTab(index) {
    state.pageIndex = index;
    pageController.animateToPage(
      state.pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
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
