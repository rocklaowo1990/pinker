import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/setting/user_name/library.dart';
import 'package:pinker/utils/utils.dart';

class SetUserNameController extends GetxController {
  final state = SetUserNameState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final arguments = Get.arguments;

  @override
  void onReady() {
    super.onReady();
    textController.addListener(() {
      String text = textController.text;
      if (isUserName(text)) {
        state.isDissable = false;
      } else {
        state.isDissable = true;
      }
    });
  }

  void handleSure() {}
}
