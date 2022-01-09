import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/community/hot/library.dart';
import 'package:pinker/pages/application/controller.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListHotController extends GetxController {
  final ContentListHotState state = ContentListHotState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final ApplicationController applicationController = Get.find();
  int pageIndex = 1;

  void onRefresh() async {
    refreshController.resetNoData();
    pageIndex = 1;
    await futureMill(300);
    await getContentList(
      listRx: applicationController.state.contentListHot,
      pageNo: pageIndex,
      type: 3,
    );
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (applicationController.state.contentListHot.value.totalSize >= 20) {
      pageIndex++;

      ResponseEntity responseEntity = await ContentApi.contentList(
        pageNo: pageIndex,
        type: 3,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        applicationController.state.contentListHot.update((val) {
          val!.list.addAll(contentList.list);
        });

        applicationController.state.contentListHot.value.totalSize =
            contentList.totalSize;
        refreshController.loadComplete();

        // await StorageUtil()
        //     .setJSON(storageHotContentListKey, applicationController.state.contentList.value);
      } else {
        pageIndex--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }
}
