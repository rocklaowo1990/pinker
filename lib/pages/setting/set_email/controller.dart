import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/pages/setting/set_email/library.dart';

import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class SetEmailController extends GetxController {
  final state = SetEmailState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final MyController myController = Get.find();
  final String arguments = Get.arguments;

  /// 输入框文本监听
  void _textListener() {
    textController.addListener(() {
      if (!textController.text.isEmail) {
        state.isDissable = true;

        /// 其他
      } else {
        state.isDissable = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    focusNode.requestFocus();
    _textListener();
  }

  void handleNext() async {
    /// 下一步按钮，点击事件
    getDialog(
      child: DialogChild.alert(
        onPressedLeft: _edit,
        onPressedRight: _sure,
        title: Lang.registerVerifyEmail.tr,
        content: Lang.registerDialogEmail_1.tr +
            getEmailHide(textController.text) +
            Lang.registerDialogEmail_2.tr,
      ),
      autoBack: true,
    );
  }

  void _edit() {
    Get.back();
  }

  void _sure() async {
    Get.back();
    focusNode.unfocus();
    Map<String, dynamic> data = {
      'account': textController.text,
      'areaCode': state.code,
      'password': arguments,
      'entryType': '1',
      'accountType': '2',
    };
    Get.toNamed(
      AppRoutes.set + AppRoutes.checkPassword + AppRoutes.setVerify,
      arguments: data,
    );
  }
}
