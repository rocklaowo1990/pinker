import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/account.dart';

import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/setting/check_password/library.dart';
import 'package:pinker/routes/app_pages.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class CheckPasswordController extends GetxController {
  final state = CheckPasswordState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final ApplicationController applicationController = Get.find();

  final String arguments = Get.arguments;

  @override
  void onReady() {
    super.onReady();
    focusNode.requestFocus();
    textController.addListener(() {
      String text = textController.text;
      if (text.isNotEmpty) {
        state.isDissable = false;
      } else {
        state.isDissable = true;
      }
    });
  }

  void handleNext() async {
    getDialog();
    focusNode.unfocus();

    Map<String, dynamic> data = {
      'password': duMD5(textController.text),
      'type': '1',
    };

    ResponseEntity responseEntity = await AccountApi.checkPassword(data);
    if (responseEntity.code == 200) {
      String data = duMD5(textController.text);
      await futureMill(500);
      Get.back();
      Get.toNamed(
        AppRoutes.set + AppRoutes.checkPassword + arguments,
        arguments: arguments == AppRoutes.setVerify
            ? {
                'password': duMD5(textController.text),
                'userId': applicationController.state.userInfoMap['userId'],
                'verifyType': 3,
              }
            : data,
      );
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }
}
