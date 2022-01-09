import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/community/new/library.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentListNewController extends GetxController {
  final ContentListNewState state = ContentListNewState();
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
      listRx: applicationController.state.contentListNew,
      pageNo: pageIndex,
      type: 3,
    );
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await futureMill(300);
    if (applicationController.state.contentListNew.value.totalSize >= 20) {
      pageIndex++;

      ResponseEntity responseEntity = await ContentApi.contentList(
        pageNo: pageIndex,
        type: 2,
      );

      if (responseEntity.code == 200) {
        ContentListEntities contentList =
            ContentListEntities.fromJson(responseEntity.data);

        applicationController.state.contentListNew.update((val) {
          val!.list.addAll(contentList.list);
        });

        applicationController.state.contentListNew.value.totalSize =
            contentList.totalSize;
        refreshController.loadComplete();

        // await StorageUtil()
        //     .setJSON(storageNewContentListKey, applicationController.state.contentListNew.value);
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
