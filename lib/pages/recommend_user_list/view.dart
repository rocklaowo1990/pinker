import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/recommend_user_list/library.dart';

import 'package:pinker/routes/routes.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class RecommendUserListView extends GetView<RecommendUserListController> {
  const RecommendUserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget loading = getLoadingIcon();

    // 没有数据的时候，显示暂无数据
    Widget noData = getNoDataIcon();

    // 整体布局
    Widget _body = Obx(() => controller
            .applicationController.state.recommendUserList.value.list.isEmpty
        ? SingleChildScrollView(child: noData)
        : SafeArea(
            child: getRefresher(
              controller: controller.refreshController,
              child: ListView(
                children: controller
                    .applicationController.state.recommendUserList.value.list
                    .map(
                      (item) => getUserList(
                        item.avatar,
                        item.userName,
                        item.nickName,
                        intro: item.intro,
                        color: AppColors.secondBacground,
                        border: const Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: AppColors.line,
                          ),
                        ),
                        avatarPressed: () {
                          Get.toNamed(
                            AppRoutes.personal,
                            arguments: item.userId,
                          );
                        },
                        buttonPressed: () {
                          getSubscribeBox(
                            userId: item.userId,
                            avatar: item.avatar,
                            userName: item.nickName,
                            reSault: () async {
                              await getRecommendList(pageNo: 1);
                              await getContentListAll();
                            },
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
              onLoading: () {
                controller.onLoading();
              },
              onRefresh: () {
                controller.onRefresh();
              },
            ),
            top: false,
          ));

    /// body
    Widget body = Obx(() => controller.state.isLoading ? loading : _body);

    return Scaffold(
      appBar: getAppBar(
        getSpan('推荐订阅'),
        backgroundColor: AppColors.secondBacground,
        lineColor: AppColors.line,
      ),
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
