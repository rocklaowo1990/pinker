import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/user_list.dart';

import 'package:pinker/pages/application/community/search/library.dart';

import 'package:pinker/pages/application/community/search/user/library.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListSearchUserController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final SearchController searchController = Get.find();
  final state = ContentListSearchUserState();
  int pageNo = 1;

  void handleNoData() async {
    state.isLoading = true;

    ResponseEntity responseEntity = await UserApi.list(
      type: 0,
      keywords: searchController.keywords,
      pageNo: pageNo,
    );
    if (responseEntity.code == 200) {
      searchController.state.recommendUserSearchList.value =
          UserListEntities.fromJson(responseEntity.data);
      searchController.state.recommendUserSearchList.update((val) {});
    } else {
      getSnackTop(responseEntity.msg);
    }
    state.isLoading = false;
  }

  void handSubscribeinfo(item) async {
    searchController.state.recommendUserSearchList.update((val) {
      val!.list.remove(item);
    });

    await getContentListAll();

    if (searchController.state.recommendUserSearchList.value.list.length <= 4) {
      await getRecommendList(1);
    }
  }

  void onRefresh() async {
    refreshController.resetNoData();
    pageNo = 1;
    await futureMill(300);
    ResponseEntity responseEntity = await UserApi.list(
      type: 0,
      keywords: searchController.keywords,
      pageNo: pageNo,
    );
    if (responseEntity.code == 200) {
      searchController.state.recommendUserSearchList.value =
          UserListEntities.fromJson(responseEntity.data);
      searchController.state.recommendUserSearchList.update((val) {});
    } else {
      getSnackTop(responseEntity.msg);
    }
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (searchController.state.recommendUserSearchList.value.totalSize >= 20) {
      pageNo++;

      ResponseEntity responseEntity = await UserApi.list(
        type: 0,
        keywords: searchController.keywords,
        pageNo: pageNo,
      );

      if (responseEntity.code == 200) {
        searchController.state.recommendUserSearchList.value =
            UserListEntities.fromJson(responseEntity.data);
        searchController.state.recommendUserSearchList.update((val) {});

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
