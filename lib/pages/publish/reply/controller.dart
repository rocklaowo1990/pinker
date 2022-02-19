import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/publish/library.dart';

import 'package:pinker/pages/publish/reply/library.dart';
import 'package:pinker/widgets/widgets.dart';

class ReplyController extends GetxController {
  final textController = TextEditingController();
  final state = ReplyState();
  final PublishController publishController = Get.find();

  String? groupName;

  @override
  void onReady() async {
    super.onReady();
    state.replyPermissionType =
        publishController.state.publish.value.replyPermissionType;
    state.replyGroupId =
        publishController.state.publish.value.replyGroupId ?? 0;
    ResponseEntity responseEntity = await SubscribeGroupApi.list(
      pageNo: 1,
    );
    if (responseEntity.code == 200) {
      GroupListEntities groupListEntities =
          GroupListEntities.fromJson(responseEntity.data);
      state.groupList.addAll(groupListEntities.list);
    } else {
      getSnackTop(responseEntity.msg);
    }
  }
}
