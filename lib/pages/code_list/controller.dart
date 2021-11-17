import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/code_list/library.dart';
import 'package:pinker/pages/frame/register/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CodeListController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final RegisterController registerController = Get.find();
  final state = CodeListState();

  @override
  void onInit() async {
    super.onInit();

    textController.addListener(() {
      state.searchValue = textController.text;
      if (state.searchValue.isEmpty) {
        var codeListJson = StorageUtil().getJSON(storageCodeListOpenKey);
        state.showList = codeListJson['list'];
      }
    });

    debounce(
      state.searchRx,
      (String value) {
        var codeListJson = StorageUtil().getJSON(storageCodeListOpenKey);
        List codeList = codeListJson['list'];
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
      time: const Duration(milliseconds: 1000),
    );
  }

  @override
  void onReady() async {
    super.onReady();

    /// 查找本地区号数据，如果不存在就发送请求
    var codeListJson = StorageUtil().getJSON(storageCodeListOpenKey);
    if (codeListJson == null) {
      ResponseEntity responseEntity = await CommonApi.getAreaCodeList();
      if (responseEntity.code == 200) {
        StorageUtil().setJSON(storageCodeListOpenKey, responseEntity.data);
        codeListJson = StorageUtil().getJSON(storageCodeListOpenKey);
      } else {
        getSnackTop(responseEntity.msg);
      }
    }
    state.showList = codeListJson['list'];
  }

  /// 返回上一页
  void handleBack() {
    Get.back();
  }

  /// 列表选择事件
  void handleChooise(item) {
    registerController.state.code = '${item['area_code']}';
    debugPrint(registerController.state.code);
    Get.back();
  }

  @override
  void dispose() {
    registerController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
