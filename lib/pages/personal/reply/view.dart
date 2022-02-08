import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/personal/reply/library.dart';

import 'package:pinker/widgets/widgets.dart';

Widget personalReplyView() {
  return GetBuilder<PersonalReplyController>(
      init: PersonalReplyController(),
      builder: (controller) {
        // loading时显示转圈圈
        Widget loading = getLoadingIcon();

        // 没有数据的时候，显示暂无数据
        Widget noData = getNoDataIcon();

        // 整体布局
        Widget _body = Obx(() =>
            controller.personalController.state.personalReply.value.list.isEmpty
                ? noData
                : SafeArea(
                    child: getRefresher(
                      controller: controller.refreshController,
                      child: ListView.builder(
                        itemCount: controller.personalController.state
                            .personalReply.value.list.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return getContentListView(
                              controller.personalController.state.personalReply,
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
