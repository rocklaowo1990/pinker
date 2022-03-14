import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/routes/routes.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 推文列表里的头像部分
/// 这里分开也是因为不仅一个地方调用该事件
/// 本部分也包含点击事件
Widget getContentAvatar(Rx<ContentListEntities> contentList, int index) {
  void _onPressed() {
    Get.toNamed(
      AppRoutes.personal,
      arguments: contentList.value.list[index].author.userId,
    );
  }

  return getUserAvatar(
    contentList.value.list[index].author.avatar,
    contentList.value.list[index].author.nickName,
    '${contentList.value.list[index].author.userName} · ${getDate(contentList.value.list[index].createDate)}',
    onPressed: _onPressed,
  );
}

/// 这是推文里的更多按钮
Center getContentMore(
  Rx<ContentListEntities> contentList,
  int index, {
  Color background = Colors.transparent,
  double? width,
  double? height,
  int? type,
}) {
  void _onPressed() async {
    // ResponseEntity responseEntity = await UserApi.oneSubscribeInfo(
    //     userId: contentList.value.list[index].author.userId);
    // print(responseEntity.data);
    // print(contentList.value.list[index].canSee);

    // ResponseEntity responseEntity =
    //     await ContentApi.contentDetail(wid: contentList.value.list[index].wid);
    // print(responseEntity.data);
    getContentMoreSheet(
      contentList: contentList,
      index: index,
    );
  }

  return Center(
    child: getButton(
      width: width ?? 60,
      height: height ?? 60,
      background: background,
      onPressed: _onPressed,
      child: const Icon(
        Icons.more_horiz,
        color: AppColors.mainIcon,
      ),
    ),
  );
}
