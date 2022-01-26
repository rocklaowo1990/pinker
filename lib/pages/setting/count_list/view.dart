import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/setting/count_list/library.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

class SetCountListView extends GetView<SetCountListController> {
  const SetCountListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 搜索框
    Widget searchBox = getSearchInput(
      controller.textController,
      controller.focusNode,
      borderRadius: BorderRadius.zero,
    );
    AppBar appBar = getNoLineBar(controller.arguments.title);

    /// body
    Widget body = Obx(() => controller.state.isLoading
        ? getLoadingIcon()
        : Column(children: [
            searchBox,
            controller.state.showList.isEmpty
                ? getNoDataIcon()
                : Expanded(
                    child: getRefresher(
                    controller: controller.refreshController,
                    child: ListView(
                        children: controller.state.showList
                            .map((item) => Container(
                                color: AppColors.secondBacground,
                                child: getUserList(item['avatar'],
                                    item['userName'], item['nickName'],
                                    buttonText: '移出', buttonPressed: () {
                                  controller.handleListOnTap(item);
                                })))
                            .toList()),
                    onLoading: controller.onLoading,
                    isFooter:
                        controller.state.showList.length < 20 ? false : true,
                    onRefresh: controller.onRefresh,
                  )),
          ]));

    return Scaffold(
      appBar: appBar,
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
