import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/setting/count_list/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SetCountListController extends GetxController {
  /// 状态管理
  final SetCountListState state = SetCountListState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  final ApplicationController applicationController = Get.find();

  final SetCountListEntities arguments = Get.arguments;

  /// 用来保存所有的列表，暂存
  /// 可用于搜索
  final List _dataList = [];

  int pageIndex = 1;
  int totalSize = 0;

  void onRefresh() async {
    await futureMill(300);
    _refresh();
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  Future<void> _refresh() async {
    pageIndex = 1;
    totalSize = 0;
    Map<String, dynamic> data = {
      'pageNo': 1,
      'pageSize': 20,
    };

    ResponseEntity responseEntity =
        await UserApi.getCountList(arguments.getCountUrl, data);
    if (responseEntity.code == 200) {
      _dataList.addAll(responseEntity.data['list']);
      state.showList.clear();
      state.showList.addAll(responseEntity.data['list']);

      state.isLoading = false;
      totalSize = responseEntity.data['totalSize'];

      applicationController.state.userInfoMap[arguments.countType] = totalSize;
      await StorageUtil()
          .setJSON(storageUserInfoKey, applicationController.state.userInfoMap);
    } else {
      getSnackTop(responseEntity.msg);
      state.isLoading = false;
    }
  }

  void onLoading() async {
    await futureMill(300);
    if (totalSize >= 20) {
      pageIndex++;
      Map<String, dynamic> data = {
        'pageNo': pageIndex,
        'pageSize': 20,
      };

      ResponseEntity responseEntity =
          await UserApi.getCountList(arguments.getCountUrl, data);

      if (responseEntity.code == 200) {
        state.showList.addAll(responseEntity.data['list']);
        _dataList.addAll(responseEntity.data['list']);

        state.isLoading = false;
        totalSize = responseEntity.data['totalSize'];
        refreshController.loadComplete();

        applicationController.state.userInfoMap[arguments.countType] =
            totalSize;
        await StorageUtil().setJSON(
            storageUserInfoKey, applicationController.state.userInfoMap);
      } else {
        pageIndex--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  void handleListOnTap(item) {
    getDialog(
      child: DialogChild.alert(
        title: arguments.secondTitle,
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
    Map<String, dynamic> data = {
      'userId': item['userId'],
      arguments.dataName: 0,
    };

    ResponseEntity responseEntity =
        await UserApi.blockHide(arguments.setCountUrl, data);

    if (responseEntity.code == 200) {
      applicationController.state.userInfoMap[arguments.countType] =
          _dataList.length - 1;

      await StorageUtil()
          .setJSON(storageUserInfoKey, applicationController.state.userInfoMap);
      await futureMill(500);

      Get.back();
      state.showList.remove(item);
      _dataList.remove(item);
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
    _refresh();

    textController.addListener(() {
      state.searchValue = textController.text;
    });

    debounce(
      state.searchRx,
      (String value) {
        state.showList = [];

        if (value.isNotEmpty) {
          for (int i = 0; i < _dataList.length; i++) {
            if (isInclude(_dataList[i]['userName'], value.toUpperCase()) ||
                isInclude(_dataList[i]['nickName'], value.toUpperCase())) {
              state.showList.add(_dataList[i]);
            }
          }
        } else {
          state.showList.addAll(_dataList); //拷贝
        }
      },
      time: const Duration(milliseconds: 300),
    );
  }
}
