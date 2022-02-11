import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/community/sub/library.dart';

import 'package:pinker/pages/application/controller.dart';
import 'package:pinker/routes/routes.dart';


import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListSubController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final ApplicationController applicationController = Get.find();
  final state = ContentListSubState();
  int pageIndex = 1;

  void handleNoData() async {
    applicationController.state.isLoadingSub = true;
    await getHomeContentList();
    applicationController.state.isLoadingSub = false;
  }

  void handleRemmondMore() {
    Get.toNamed(AppRoutes.recommendUserList);
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
    if (applicationController.state.contentListSub.value.totalSize >= 20) {
      pageIndex++;

      ResponseEntity responseEntity = await ContentApi.homeContentList(
        pageNo: pageIndex,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        applicationController.state.contentListSub.update((val) {
          val!.list.addAll(contentList.list);
        });

        applicationController.state.contentListSub.value.totalSize =
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

    if (applicationController.state.contentListSub.value.list.isEmpty) {
      await getHomeContentList();
      applicationController.state.isLoadingSub = false;
    } else {
      applicationController.state.isLoadingSub = false;
    }
  }
}
