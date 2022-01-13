import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/pages/application/community/search/library.dart';
import 'package:pinker/widgets/widgets.dart';

class CommunityController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// 响应式成员
  final CommunityState state = CommunityState();

  late TabController tabController;

  /// 页面控制器
  final pageController = PageController();

  void handleChangedTab(index) {
    state.pageIndex = index;
    pageController.animateToPage(
      state.pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    // index == 0 ? Get.back(id: 3) : Get.toNamed(AppRoutes.contentHot, id: 3);
  }

  void handlePageChanged(index) {
    state.pageIndex = index;
    tabController.animateTo(index);
  }

  void handleSearch() {
    getDialog(child: const SearchView());
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }
}
