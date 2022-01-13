import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/community/search/library.dart';

class SearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  final SearchState state = SearchState();

  final TextEditingController textController = TextEditingController();
  late TabController tabController;
  final FocusNode focusNode = FocusNode();

  void handleSearch() {
    focusNode.unfocus();

    state.isSearchEnd = true;
    state.textData.add(textController.text);
    state.textData.toSet();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 6, vsync: this);
  }

  void handlePageChanged(index) {}

  @override
  void onReady() {
    super.onReady();

    focusNode.requestFocus();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        state.isSearchEnd = false;
      }
    });

    textController.addListener(() {
      state.isShowSearch = textController.text.isEmpty ? false : true;
    });
  }
}
