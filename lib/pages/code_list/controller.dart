import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/code_list/index.dart';
import 'package:pinker/pages/frame/register/index.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CodeListController extends GetxController {
  final registerController = Get.put(RegisterController());
  final state = CodeListState();

  @override
  void onInit() async {
    /// 查找本地区号数据，如果不存在就发送请求
    var codeListJson = StorageUtil().getJSON(storageCodeListOpenKey);
    if (codeListJson == null) {
      ResponseEntity responseEntity = await CommonApi.getAreaCodeList();
      if (responseEntity.code == 200) {
        StorageUtil().setJSON(storageCodeListOpenKey, responseEntity.data);
        codeListJson = StorageUtil().getJSON(storageCodeListOpenKey);
      } else {
        getSnackTop(msg: responseEntity.msg);
      }
    }
    state.codeList = codeListJson['list'];

    super.onInit();
  }

  /// 返回上一页
  void handleBack() {
    Get.back();
  }

  /// 列表选择事件
  void handleChooise(item) {
    registerController.state.code = '+${item['area_code']}';
    debugPrint(registerController.state.code);
    Get.back();
  }

  @override
  void dispose() {
    registerController.dispose();
    super.dispose();
  }
}
