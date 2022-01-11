import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/application/community/free/library.dart';

import 'package:pinker/pages/application/controller.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListFreeController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final ApplicationController applicationController = Get.find();
  final state = ContentListFreeState();
  int pageIndex = 1;

  void handleNoData() async {
    applicationController.state.isLoadingFree = true;
    await getContentList(
      listRx: applicationController.state.contentListFree,
      pageNo: 1,
      type: 6,
    );
    applicationController.state.isLoadingFree = false;
  }

  void onRefresh() async {
    refreshController.resetNoData();
    pageIndex = 1;
    await futureMill(300);
    await getContentList(
      listRx: applicationController.state.contentListFree,
      pageNo: pageIndex,
      type: 6,
    );
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (applicationController.state.contentListFree.value.totalSize >= 20) {
      pageIndex++;

      ResponseEntity responseEntity = await ContentApi.contentList(
        pageNo: pageIndex,
        type: 6,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        applicationController.state.contentListFree.update((val) {
          val!.list.addAll(contentList.list);
        });

        applicationController.state.contentListFree.value.totalSize =
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

    if (applicationController.state.contentListFree.value.list.isEmpty) {
      await getContentList(
        listRx: applicationController.state.contentListFree,
        type: 6,
        pageNo: 1,
      );
      applicationController.state.isLoadingFree = false;
    } else {
      applicationController.state.isLoadingFree = false;
    }
  }
}
