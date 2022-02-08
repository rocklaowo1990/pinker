import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/personal/like/library.dart';

import 'package:pinker/widgets/widgets.dart';

Widget personalLikeView() {
  return GetBuilder<PersonalLikeController>(
      init: PersonalLikeController(),
      builder: (controller) {
        // loading时显示转圈圈
        Widget loading = getLoadingIcon();

        // 没有数据的时候，显示暂无数据
        Widget noData = getNoDataIcon();

        // 整体布局
        Widget _body = Obx(() =>
            controller.personalController.state.personalLike.value.list.isEmpty
                ? noData
                : SafeArea(
                    child: getRefresher(
                      controller: controller.refreshController,
                      child: ListView.builder(
                        itemCount: controller.personalController.state
                            .personalLike.value.list.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return getContentListView(
                              controller.personalController.state.personalLike,
                              index);
                        },
                      ),
                      onLoading: controller.onLoading,
                      onRefresh: controller.onRefresh,
                    ),
                    top: false,
                  ));

        /// body
        Widget body = Obx(() => controller.state.isLoading ? loading : _body);

        return body;
      });
}
