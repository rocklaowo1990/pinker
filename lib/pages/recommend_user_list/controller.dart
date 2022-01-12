import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/subscribe_list.dart';
import 'package:pinker/entities/user_list.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/subscribe_list/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendUserListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();
  final SubscribeListState state = SubscribeListState();
  final ApplicationController applicationController = Get.find();

  int pageNo = 1;
  int totalSize = 0;

  void onLoading() async {
    await futureMill(300);

    if (totalSize >= 20) {
      pageNo++;

      ResponseEntity responseEntity = await UserApi.list(
        type: 2,
        pageNo: pageNo,
      );

      if (responseEntity.code == 200) {
        UserListEntities _list = UserListEntities.fromJson(responseEntity.data);
        applicationController.state.recommendUserList.update((val) {
          val!.list.addAll(_list.list);
        });

        state.isLoading = false;

        totalSize = state.subscribeList.value.totalSize - 4;
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

  Future<void> _refresh() async {
    pageNo = 1;
    getHomeData(pageNo);
  }

  void onRefresh() async {
    refreshController.resetNoData();

    await futureMill(300);
    _refresh();
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  @override
  void onReady() async {
    super.onReady();

    await getHomeData(pageNo);
    state.isLoading = false;
  }
}
