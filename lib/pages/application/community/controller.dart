import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';

import 'package:pinker/pages/application/community/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityController extends GetxController {
  /// 响应式成员
  final CommunityState state = CommunityState();

  /// 页面控制器
  final PageController pageController = PageController();

  final RefreshController refreshControllerNew =
      RefreshController(initialRefresh: false);
  final RefreshController refreshControllerHot =
      RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  void handleChangedTab(index) {
    state.pageIndex = index;
    pageController.animateToPage(
      state.pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void handlePageChanged(index) {
    state.pageIndex = index;
  }

  int pageIndexNew = 1;
  int totalSizeNew = 0;

  int pageIndexHot = 1;
  int totalSizeHot = 0;

  void onRefresh(
    int type,
  ) async {
    await futureMill(1000);

    if (type == 2) {
      refreshControllerNew.resetNoData();
      _refresh(2);
    } else {
      refreshControllerHot.resetNoData();
      _refresh(3);
    }

    await futureMill(1000);

    type == 2
        ? refreshControllerNew.refreshCompleted()
        : refreshControllerHot.refreshCompleted();
  }

  void onLoading(
    int type,
  ) async {
    // monitor network fetch
    await futureMill(2000);

    if (type == 2) {
      if (totalSizeNew >= 20) {
        pageIndexNew++;
        Map<String, dynamic> data = {
          'pageNo': pageIndexNew,
          'pageSize': 20,
          'type': 3,
        };

        ResponseEntity responseEntity = await ContentApi.contentList(data);

        if (responseEntity.code == 200) {
          ContentList contentList = ContentList.fromJson(responseEntity.data);
          state.showListNew.addAll(contentList.list);

          state.isLoadingNew = false;
          totalSizeNew = contentList.totalSize;
          refreshControllerNew.loadComplete();
          Map<String, dynamic> _storageUserContentList = {
            'list': state.showListNew,
            'totalSize': state.showListNew.length,
          };
          await StorageUtil()
              .setJSON(storageNewContentListKey, _storageUserContentList);
        } else {
          pageIndexNew--;
          refreshControllerNew.loadFailed();
          getSnackTop(responseEntity.msg);
        }
      } else {
        refreshControllerNew.loadNoData();
      }
    } else {
      if (totalSizeHot >= 20) {
        pageIndexHot++;
        Map<String, dynamic> data = {
          'pageNo': pageIndexHot,
          'pageSize': 20,
          'type': 3,
        };

        ResponseEntity responseEntity = await ContentApi.contentList(data);

        if (responseEntity.code == 200) {
          ContentList contentList = ContentList.fromJson(responseEntity.data);
          state.showListHot.addAll(contentList.list);

          state.isLoadingHot = false;
          totalSizeHot = contentList.totalSize;
          refreshControllerHot.loadComplete();
          Map<String, dynamic> _storageUserContentList = {
            'list': state.showListHot,
            'totalSize': state.showListHot.length,
          };
          await StorageUtil()
              .setJSON(storageHotContentListKey, _storageUserContentList);
        } else {
          pageIndexHot--;
          refreshControllerHot.loadFailed();
          getSnackTop(responseEntity.msg);
        }
      } else {
        refreshControllerHot.loadNoData();
      }
    }
  }

  Future<void> _refresh(
    int type,
  ) async {
    if (type == 2) {
      pageIndexNew = 1;
      totalSizeNew = 0;
    } else {
      pageIndexHot = 1;
      totalSizeHot = 0;
    }

    Map<String, dynamic> data = {
      'pageNo': 1,
      'pageSize': 20,
      'type': type,
    };

    ResponseEntity responseEntity = await ContentApi.contentList(data);
    if (responseEntity.code == 200) {
      ContentList contentList = ContentList.fromJson(responseEntity.data);

      if (type == 2) {
        state.showListNew.clear();
        state.showListNew.addAll(contentList.list);
        state.isLoadingNew = false;
        totalSizeNew = contentList.totalSize;
        await StorageUtil()
            .setJSON(storageNewContentListKey, responseEntity.data);
        await StorageUtil().setBool(storageIsHadUserInfo, true);
      } else {
        state.showListHot.clear();
        state.showListHot.addAll(contentList.list);
        state.isLoadingHot = false;
        totalSizeHot = contentList.totalSize;
        await StorageUtil()
            .setJSON(storageHotContentListKey, responseEntity.data);
        await StorageUtil().setBool(storageIsHadUserInfo, true);
      }

      Global.isHadUserInfo = true;
    } else {
      getSnackTop(responseEntity.msg);
      type == 2 ? state.isLoadingNew = false : state.isLoadingHot = false;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    if (Global.isHadPublicContent) {
      state.isLoadingNew = false;
      state.isLoadingHot = false;

      Map<String, dynamic> _contentListNew =
          await StorageUtil().getJSON(storageNewContentListKey);
      Map<String, dynamic> _contentListHot =
          await StorageUtil().getJSON(storageHotContentListKey);

      ContentList contentListNew = ContentList.fromJson(_contentListNew);
      ContentList contentListHot = ContentList.fromJson(_contentListHot);

      pageIndexNew = contentListNew.list.length ~/ 20;
      pageIndexHot = contentListHot.list.length ~/ 20;

      totalSizeNew = contentListNew.list.length % 20 == 0
          ? 20
          : contentListNew.list.length % 20;

      totalSizeHot = contentListHot.list.length % 20 == 0
          ? 20
          : contentListHot.list.length % 20;

      state.showListNew.addAll(contentListNew.list);
      state.showListHot.addAll(contentListHot.list);
    } else {
      await _refresh(2);
      await _refresh(3);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    refreshControllerNew.dispose();
    refreshControllerHot.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
