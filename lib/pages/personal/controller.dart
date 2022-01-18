import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/personal.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/personal/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PersonalState state = PersonalState();
  final RefreshController refreshController = RefreshController();

  final ApplicationController applicationController = Get.find();

  late TabController tabController;
  final pageController = PageController();

  final int arguments = Get.arguments;

  int pageNo = 1;

  void onRefresh() async {
    refreshController.resetNoData();
    pageNo = 1;

    await futureMill(300);
    await getHomeData();
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

  void handlePageChanged(index) {
    state.pageIndex = index;
    tabController.animateTo(index);
  }

  @override
  void onReady() async {
    super.onReady();
    ResponseEntity responseEntity = await UserApi.home(userId: arguments);
    if (responseEntity.code == 200) {
      state.intro.value = PersonalEntities.fromJson(responseEntity.data);
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
  }
}
