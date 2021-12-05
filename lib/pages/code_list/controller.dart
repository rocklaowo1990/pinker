import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/code_list/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CodeListController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final state = CodeListState();

  final String arguments = Get.arguments;

  List codeList = [];

  @override
  void onReady() async {
    super.onReady();

    ResponseEntity responseEntity = await CommonApi.getAreaCodeList();
    if (responseEntity.code == 200) {
      await StorageUtil()
          .setJSON(storageCodeListOpenKey, responseEntity.data!['list']);
      codeList = responseEntity.data!['list'];
      state.showList.addAll(codeList);
      state.isLoading = false;
    } else {
      getSnackTop(responseEntity.msg);
    }

    textController.addListener(() {
      state.searchValue = textController.text;
      if (state.searchValue.isEmpty) {
        state.showList.addAll(codeList);
      }
    });

    debounce(
      state.searchRx,
      (String value) {
        if (value.isNotEmpty) {
          state.showList.clear();
          for (int i = 0; i < codeList.length; i++) {
            if (isInclude(codeList[i]['area_code'], value) ||
                isInclude(codeList[i]['op_name'], value) ||
                isInclude(codeList[i]['country'], value.toUpperCase())) {
              state.showList.add(codeList[i]);
            }
          }
        }
      },
      time: const Duration(milliseconds: 200),
    );
  }

  /// 返回上一页
  void handleBack() {
    Get.back();
  }

  /// 列表选择事件
  void handleChooise(item) {
    Get.back(result: item['area_code']);
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
