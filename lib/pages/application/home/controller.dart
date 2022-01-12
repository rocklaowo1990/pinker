import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/routes/app_pages.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final ApplicationController applicationController = Get.find();
  final ScrollController scrollController = ScrollController();

  int pageNo = 1;

  void handleMail() {}

  void handleNoData() async {
    applicationController.state.isLoadingHome = true;
    await getHomeContentList();
    applicationController.state.isLoadingHome = false;
  }

  void onRefresh() async {
    refreshController.resetNoData();
    pageNo = 1;

    await futureMill(300);
    await getHomeContentList();
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (applicationController.state.contentListHome.value.totalSize >= 20) {
      pageNo++;

      ResponseEntity responseEntity = await ContentApi.homeContentList(
        pageNo: pageNo,
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
        pageNo--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  void handSubscribeinfo(item) async {
    applicationController.state.recommendUserList.update((val) {
      val!.list.remove(item);
    });

    await getContentListAll();

    if (applicationController.state.recommendUserList.value.list.length <= 4) {
      await getHomeData(1);
    }
  }

  void handleRemmondMore() {
    Get.toNamed(AppRoutes.recommendUserList);
  }

  @override
  void onReady() async {
    super.onReady();
    if (applicationController.state.recommendUserList.value.list.isEmpty) {
      await getHomeContentList();
      await getHomeData(1);
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
