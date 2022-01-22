import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/code_list/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CodeListView extends GetView<CodeListController> {
  const CodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getDefaultBar(Lang.codeTitle.tr);

    /// 搜索框
    Widget searchBox = getSearchInput(
      controller.textController,
      controller.focusNode,
      borderRadius: BorderRadius.zero,
    );

    /// body
    Widget body = Obx(() => controller.state.isLoading
        ? getLoadingIcon()
        : Column(children: [
            searchBox,
            controller.state.showList.isEmpty
                ? getNoDataIcon()
                : Expanded(
                    child: ListView(
                        children: controller.state.showList
                            .map(
                              (item) => getButtonList(
                                onPressed: () {
                                  controller.handleChooise(item);
                                },
                                title: Get.locale == const Locale('zh', 'CN')
                                    ? '+${item['areaCode']}      ${item['opName']}'
                                    : '+${item['areaCode']}      ${item['country']}',
                                iconRight: getCheckIcon(
                                    isChooise: '${item['areaCode']}' ==
                                            controller.arguments
                                        ? true
                                        : false),
                              ),
                            )
                            .toList())),
          ]));

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
