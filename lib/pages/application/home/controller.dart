import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final ApplicationController applicationController = Get.find();
  final ScrollController scrollController = ScrollController();

  int pageIndex = 1;

  void handleMail() {}

  void handleNoData() async {
    applicationController.state.isLoadingHome = true;
    await getHomeContentList();
    applicationController.state.isLoadingHome = false;
  }

  void onRefresh() async {
    refreshController.resetNoData();
    pageIndex = 1;

    await futureMill(300);
    await getHomeContentList();
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (applicationController.state.contentListHome.value.totalSize >= 20) {
      pageIndex++;

      ResponseEntity responseEntity = await ContentApi.homeContentList(
        pageNo: pageIndex,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        applicationController.state.contentListHome.update((val) {
          val!.list.addAll(contentList.list);
        });

        applicationController.state.contentListHome.value.totalSize =
            contentList.totalSize;
        refreshController.loadComplete();

        // await StorageUtil()
        //     .setJSON(storageHomeContentListKey, state.contentList.value);
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
    if (applicationController.state.contentListHome.value.list.isEmpty) {
      await getHomeContentList();
      applicationController.state.isLoadingHome = false;
    } else {
      applicationController.state.isLoadingHome = false;
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
