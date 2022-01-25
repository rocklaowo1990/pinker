import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/personal/forward/library.dart';

import 'package:pinker/widgets/widgets.dart';

Widget personalForwardView() {
  return GetBuilder<PersonalForwardController>(
      init: PersonalForwardController(),
      builder: (controller) {
        // loading时显示转圈圈
        Widget loading = getLoadingIcon();

        // 没有数据的时候，显示暂无数据
        Widget noData = getNoDataIcon();

        // 整体布局
        Widget _body = Obx(
          () => controller
                  .personalController.state.personalForward.value.list.isEmpty
              ? noData
              : getRefresher(
                  controller: controller.refreshController,
                  child: ListView.builder(
                    itemCount: controller.personalController.state
                        .personalForward.value.list.length,
                    itemBuilder: (BuildContext buildContext, int index) {
                      return getContentListView(
                          controller.personalController.state.personalForward,
                          index);
                    },
                  ),
                  onLoading: controller.onLoading,
                  onRefresh: controller.onRefresh,
                ),
        );

        /// body
        Widget body = Obx(() => controller.state.isLoading ? loading : _body);

        return body;
      });
}
