import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/search/user/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentListSearchUserView extends StatelessWidget {
  const ContentListSearchUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentListSearchUserController>(
        init: ContentListSearchUserController(),
        builder: (controller) {
          // loading时显示转圈圈
          Widget loading = getLoadingIcon();

          // 没有数据的时候，显示暂无数据
          Widget noData = getNoDataIcon();

          // 整体布局
          Widget _body = Obx(
            () => controller.searchController.state.recommendUserSearchList
                    .value.list.isEmpty
                ? noData
                : getRefresher(
                    controller: controller.refreshController,
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.searchController.state
                            .recommendUserSearchList.value.list.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return getUserList(
                              controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .avatar,
                              controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .userName,
                              controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .nickName,
                              color: AppColors.secondBacground,
                              intro: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .intro, buttonPressed: () {
                            getSubscribeBox(
                              userId: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .userId,
                              avatar: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .avatar,
                              userName: controller
                                  .searchController
                                  .state
                                  .recommendUserSearchList
                                  .value
                                  .list[index]
                                  .userName,
                              reSault: () {
                                controller.handSubscribeinfo(controller
                                    .searchController
                                    .state
                                    .recommendUserSearchList
                                    .value
                                    .list[index]);
                              },
                            );
                          },
                              border: const Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: AppColors.line)));
                        }),
                    onLoading: controller.onLoading,
                    onRefresh: controller.onRefresh,
                  ),
          );

          /// body
          Widget body = Obx(() => controller.state.isLoading ? loading : _body);

          return Scaffold(
            body: body,
            backgroundColor: AppColors.mainBacground,
          );
        });
  }
}
