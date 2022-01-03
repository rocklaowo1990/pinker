import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/global.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
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

      ResponseEntity responseEntity = await ContentApi.homeContentList(data);

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
            .setJSON(storageHomeContentListKey, state.contentList.value);
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

    ResponseEntity responseEntity = await ContentApi.homeContentList(data);
    if (responseEntity.code == 200) {
      state.contentList.value =
          ContentListEntities.fromJson(responseEntity.data);

      state.contentList.update((val) {});

      state.isLoading = false;

      await StorageUtil()
          .setJSON(storageHomeContentListKey, responseEntity.data);
    } else {
      getSnackTop(responseEntity.msg);
      state.isLoading = false;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    if (Global.isHadUserInfo) {
      Map<String, dynamic> _contentList =
          await StorageUtil().getJSON(storageHomeContentListKey);

      state.contentList.value = ContentListEntities.fromJson(_contentList);
      state.contentList.update((val) {});

      state.isLoading = false;

      pageIndex = state.contentList.value.list.length ~/ 20;
      if (state.contentList.value.totalSize > 0) pageIndex++;

      // 个人信息
      // 读取用户信息
      final _userInfo = await StorageUtil().getJSON(storageUserInfoKey);
      applicationController.state.userInfo.value =
          UserInfoEntities.fromJson(_userInfo);
      applicationController.state.userInfo.update((val) {});
    } else {
      await _refresh();
      await getUserInfo(
        applicationController.state.userInfo,
        isLoading: state.isLoadingRx,
      );
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
