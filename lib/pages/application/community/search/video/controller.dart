import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/community/search/library.dart';

import 'package:pinker/pages/application/community/search/video/library.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListSearchVideoController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final SearchController searchController = Get.find();
  final state = ContentListSearchVideoState();
  int pageNo = 1;

  void handleNoData() async {
    state.isLoading = true;
    await getContentList(
      listRx: searchController.state.contentListSearchVideo,
      pageNo: pageNo,
      type: 5,
      keywords: searchController.keywords,
    );
    state.isLoading = false;
  }

  void onRefresh() async {
    refreshController.resetNoData();
    pageNo = 1;
    await futureMill(300);
    await getContentList(
      listRx: searchController.state.contentListSearchVideo,
      type: 5,
      pageNo: pageNo,
      keywords: searchController.keywords,
    );
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (searchController.state.contentListSearchVideo.value.totalSize >= 20) {
      pageNo++;

      ResponseEntity responseEntity = await ContentApi.contentList(
        pageNo: pageNo,
        type: 5,
        keywords: searchController.keywords,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        searchController.state.contentListSearchVideo.update((val) {
          val!.list.addAll(contentList.list);
        });

        searchController.state.contentListSearchVideo.value.totalSize =
            contentList.totalSize;
        refreshController.loadComplete();
      } else {
        pageNo--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }
}
