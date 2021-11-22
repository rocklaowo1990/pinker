import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/user_list_page/controller.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getUserListPage({
  String? title,
  int? type,
}) {
  return GetBuilder<UserListPageController>(
    init: UserListPageController(type),
    builder: (controller) {
      AppBar appBar = getAppBar(
        getSpan(title ?? '请输入页面标题', fontSize: 17),
        backgroundColor: AppColors.secondBacground,
        bottom: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child:
              getSearchInput(controller.textController, controller.focusNode),
        ),
        bottomHeight: 60,
      );

      /// body
      Widget? body = Obx(() => Scrollbar(
            child: ListView(
                children: controller.state.userList
                    .map((item) => getUserList(
                        avatar: item['avatar'],
                        userName: item['userName'],
                        nickName: item['nickName'],
                        buttonText: '移出',
                        onPressed: () {
                          controller.handleListOnTap(item);
                        }))
                    .toList()),
          ));

      return Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: AppColors.mainBacground,
      );
    },
  );
}
