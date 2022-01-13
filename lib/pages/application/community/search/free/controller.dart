import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/community/search/free/library.dart';
import 'package:pinker/pages/application/community/search/library.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListSearchFreeController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final SearchController searchController = Get.find();
  final state = ContentListSearchFreeState();
  int pageIndex = 1;

  void handleNoData() async {
    state.isLoading = true;
    await getContentList(
      listRx: searchController.state.contentListSearchFree,
      pageNo: 1,
      type: 6,
    );
    state.isLoading = false;
  }

  void onRefresh() async {
    refreshController.resetNoData();
    pageIndex = 1;
    await futureMill(300);
    await getContentList(
      listRx: searchController.state.contentListSearchFree,
      pageNo: pageIndex,
      type: 6,
    );
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (searchController.state.contentListSearchFree.value.totalSize >= 20) {
      pageIndex++;

      ResponseEntity responseEntity = await ContentApi.contentList(
        pageNo: pageIndex,
        type: 6,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        searchController.state.contentListSearchFree.update((val) {
          val!.list.addAll(contentList.list);
        });

        searchController.state.contentListSearchFree.value.totalSize =
            contentList.totalSize;
        refreshController.loadComplete();
      } else {
        pageIndex--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  @override
  void onReady() async {
    super.onReady();

    if (searchController.state.contentListSearchFree.value.list.isEmpty) {
      await getContentList(
        listRx: searchController.state.contentListSearchFree,
        type: 3,
        pageNo: 1,
        keywords: searchController.textController.text,
      );
      state.isLoading = false;
    } else {
      state.isLoading = false;
    }
  }
}
