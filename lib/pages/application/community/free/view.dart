import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/community/free/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentListFreeView extends StatelessWidget {
  const ContentListFreeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentListFreeController>(
        init: ContentListFreeController(),
        builder: (controller) {
          // loading时显示转圈圈
          Widget loading = getLoadingIcon();

          // 没有数据的时候，显示暂无数据
          Widget noData = getNoDataIcon();

          // 整体布局
          Widget _body = Obx(
            () => controller.applicationController.state.contentListFree.value
                    .list.isEmpty
                ? noData
                : getRefresher(
                    controller: controller.refreshController,
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.applicationController.state
                          .contentListFree.value.list.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        return getContentListView(
                            controller
                                .applicationController.state.contentListFree,
                            index);
                      },
                    ),
                    onLoading: controller.onLoading,
                    onRefresh: controller.onRefresh,
                  ),
          );

          /// body
          Widget body = Obx(() =>
              controller.applicationController.state.isLoadingFree
                  ? loading
                  : _body);

          return Scaffold(
            body: body,
            backgroundColor: AppColors.mainBacground,
          );
        });
  }
}
