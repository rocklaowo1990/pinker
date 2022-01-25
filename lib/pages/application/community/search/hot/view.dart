import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/application/community/search/hot/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ContentListSearchHotView extends StatelessWidget {
  const ContentListSearchHotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentListSearchHotController>(
        init: ContentListSearchHotController(),
        builder: (controller) {
// loading时显示转圈圈
          Widget loading = getLoadingIcon();

          // 没有数据的时候，显示暂无数据
          Widget noData = getNoDataIcon();

          // 整体布局
          Widget _body = Obx(
            () => controller.searchController.state.contentListSearchHot.value
                    .list.isEmpty
                ? noData
                : getRefresher(
                    controller: controller.refreshController,
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.searchController.state
                            .contentListSearchHot.value.list.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return getContentListView(
                              controller
                                  .searchController.state.contentListSearchHot,
                              index);
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
