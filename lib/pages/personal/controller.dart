import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/personal/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PersonalState state = PersonalState();
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

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

  void handleSub() {
    getSubscribeBox(
      userId: state.intro.value.userId,
      avatar: state.intro.value.avatar,
      userName: state.intro.value.userName,
      reSault: () async {
        ResponseEntity responseEntity = await UserApi.home(userId: arguments);
        if (responseEntity.code == 200) {
          state.intro.value = PersonalEntities.fromJson(responseEntity.data);
        } else {
          getSnackTop(responseEntity.msg);
        }

        Future<void> _getPersonalContent(
            int type, Rx<ContentListEntities> rx) async {
          ResponseEntity responseEntity = await ContentApi.userHomeContentList(
            pageNo: 1,
            type: type,
            userId: arguments,
          );

          if (responseEntity.code == 200) {
            rx.value = ContentListEntities.fromJson(responseEntity.data);
            rx.update((val) {});
          } else {
            getSnackTop(responseEntity.msg);
          }
        }

        await _getPersonalContent(1, state.personalAll);
        await _getPersonalContent(2, state.personalFree);
        await _getPersonalContent(3, state.personalReply);
        await _getPersonalContent(4, state.personalForward);
        await _getPersonalContent(5, state.personalLike);
      },
    );
  }

  void handleChangedTab(index) {
    state.pageIndex = index;
    pageController.animateToPage(
      state.pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    // index == 0 ? Get.back(id: 3) : Get.toNamed(AppRoutes.contentHot, id: 3);
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
    } else {
      getSnackTop(responseEntity.msg);
    }

    scrollController.addListener(() {
      state.offsetWidth = scrollController.offset;
      if (scrollController.offset >= 50) state.opacity = 1;
      if (scrollController.offset < 50) state.opacity = 0;
    });
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
  }
}
