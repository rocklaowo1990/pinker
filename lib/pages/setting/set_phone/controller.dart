import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/pages/setting/set_phone/library.dart';
import 'package:pinker/routes/app_pages.dart';

class SetPhoneController extends GetxController {
  final state = SetPhoneState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final MyController myController = Get.find();

  /// 区号选择
  void handleGoCodeList() async {
    var result = await Get.toNamed(
      AppRoutes.codeList,
      arguments: state.code,
    );

    if (result != null) state.code = result;
  }

  @override
  void onReady() {
    super.onReady();
    textController.addListener(() {
      String text = textController.text;
      if (text.isNotEmpty) {
        state.isDissable = false;
      } else {
        state.isDissable = true;
      }
    });
  }

  void handleNext() async {}
}
