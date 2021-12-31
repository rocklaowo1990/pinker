import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/community/hot/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListHotController extends GetxController {
  final ContentListHotState state = ContentListHotState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  int pageIndex = 1;

  void onRefresh() async {
    refreshController.resetNoData();

    await futureMill(300);
    _refresh();
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (state.contentList.value.totalSize >= 20) {
      pageIndex++;
      Map<String, dynamic> data = {
        'pageNo': pageIndex,
        'pageSize': 20,
        'type': 3,
      };

      ResponseEntity responseEntity = await ContentApi.contentList(data);

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        state.contentList.update((val) {
          val!.list.addAll(contentList.list);
        });

        state.isLoading = false;
        state.contentList.value.totalSize = contentList.totalSize;
        refreshController.loadComplete();

        await StorageUtil()
            .setJSON(storageHotContentListKey, state.contentList.value);
      } else {
        pageIndex--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> _refresh() async {
    pageIndex = 1;

    Map<String, dynamic> data = {
      'pageNo': 1,
      'pageSize': 20,
      'type': 3,
    };

    ResponseEntity responseEntity = await ContentApi.contentList(data);
    if (responseEntity.code == 200) {
      state.contentList.value =
          ContentListEntities.fromJson(responseEntity.data);

      state.contentList.update((val) {});

      state.isLoading = false;

      await StorageUtil()
          .setJSON(storageHotContentListKey, responseEntity.data);
    } else {
      getSnackTop(responseEntity.msg);
      state.isLoading = false;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    _refresh();
  }
}
