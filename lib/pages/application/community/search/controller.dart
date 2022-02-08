import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/community/search/library.dart';
import 'package:pinker/utils/authentication.dart';
import 'package:pinker/widgets/widgets.dart';

class SearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  final SearchState state = SearchState();

  final TextEditingController textController = TextEditingController();
  late TabController tabController;
  final FocusNode focusNode = FocusNode();
  List<String> list = ['最新', '用户', '照片', '视频'];

  String keywords = '';

  void handleChangedTab(index) {
    state.pageIndex = index;
    pageController.animateToPage(
      state.pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    // index == 0 ? Get.back(id: 3) : Get.toNamed(AppRoutes.contentHot, id: 3);
  }

  Future<void> getData() async {
    await getContentList(
      listRx: state.contentListSearchNew,
      type: 1,
      pageNo: 1,
      keywords: keywords,
    );

    await getContentList(
      listRx: state.contentListSearchPhoto,
      type: 4,
      pageNo: 1,
      keywords: keywords,
    );

    await getContentList(
      listRx: state.contentListSearchVideo,
      type: 5,
      pageNo: 1,
      keywords: keywords,
    );

    ResponseEntity responseEntity = await UserApi.list(
      type: 0,
      keywords: keywords,
      pageNo: 1,
    );
    if (responseEntity.code == 200) {
      state.recommendUserSearchList.value =
          UserListEntities.fromJson(responseEntity.data);
      state.recommendUserSearchList.update((val) {});
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

  void handleSearch(String text) async {
    focusNode.unfocus();
    keywords = textController.text;
    state.textData.add(textController.text);
    state.textData.value = state.textData.toSet().toList();
    state.pageIndex = 0;
    tabController.index = 0;
    state.isSearchEnd = true;

    await getData();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: list.length, vsync: this);
  }

  void handlePageChanged(index) {
    state.pageIndex = index;
    tabController.animateTo(index);
  }

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
