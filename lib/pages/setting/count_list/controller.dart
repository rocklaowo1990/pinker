import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/setting/count_list/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

class UserListPageController extends GetxController {
  UserListPageController(this.type);

  /// 状态管理
  final UserListPageState state = UserListPageState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final ApplicationController applicationController = Get.find();

  /// 1:屏蔽 其他的是隐藏
  final int? type;

  late final List _userList;

  int _page = 1;

  void handleListOnTap(item) {
    getDialog(
      child: DialogChild.alert(
        title: type == 1 ? '取消屏蔽' : '取消隐藏',
        content: '是否确认要继续操作',
        onPressedRight: () async {
          _sure(item);
        },
        leftText: '取消',
        onPressedLeft: _cancel,
      ),
      autoBack: true,
    );
  }

  void _cancel() {
    Get.back();
  }

  void _sure(item) async {
    Get.back();
    getDialog();
    Map<String, dynamic> data = type == 1
        ? {
            'userId': item['userId'],
            'isHide': 0,
          }
        : {
            'userId': item['userId'],
            'isBlock': 0,
          };

    ResponseEntity responseEntity =
        type == 1 ? await UserApi.block(data) : await UserApi.hide(data);

    if (responseEntity.code == 200) {
      await futureMill(500);
      type == 1
          ? applicationController.state.userInfoMap['blockCount'] =
              _userList.length - 1
          : applicationController.state.userInfoMap['hiddenCount'] =
              _userList.length - 1;

      await StorageUtil()
          .setJSON(storageUserInfoKey, applicationController.state.userInfoMap);

      Get.back();
      state.userList.remove(item);
      _userList.remove(item);
      getSnackTop('操作成功', isError: false);
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    ResponseEntity responseEntity = await UserApi.settingUserList(type, _page);
    if (responseEntity.code == 200) {
      _userList = responseEntity.data['list'];
      state.userList = responseEntity.data['list'];

      type == 1
          ? applicationController.state.userInfoMap['blockCount'] =
              _userList.length
          : applicationController.state.userInfoMap['hiddenCount'] =
              _userList.length;

      _page++;
      state.isLoading = false;
    } else {
      state.isLoading = false;
      getSnackTop(responseEntity.msg);
    }

    textController.addListener(() {
      state.searchValue = textController.text;
    });

    debounce(
      state.searchRx,
      (String value) {
        state.userList = [];

        if (value.isNotEmpty) {
          for (int i = 0; i < _userList.length; i++) {
            if (isInclude(_userList[i]['userName'], value.toUpperCase()) ||
                isInclude(_userList[i]['nickName'], value.toUpperCase())) {
              state.userList.add(_userList[i]);
            }
          }
        } else {
          state.userList.addAll(_userList); //拷贝
        }
      },
      time: const Duration(milliseconds: 300),
    );
  }
}
