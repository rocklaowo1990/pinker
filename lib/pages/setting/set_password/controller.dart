import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/pages/fogot/library.dart';

import 'package:pinker/pages/setting/set_password/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class SetPasswordController extends GetxController {
  final state = SetPasswordState();

  final TextEditingController oldController = TextEditingController();
  final FocusNode oldFocusNode = FocusNode();

  final TextEditingController newOneController = TextEditingController();
  final FocusNode newOneFocusNode = FocusNode();

  final TextEditingController newTwoController = TextEditingController();
  final FocusNode newTwoFocusNode = FocusNode();

  final MyController myController = Get.find();

  void handleSure() async {
    oldFocusNode.unfocus();
    newOneFocusNode.unfocus();
    newTwoFocusNode.unfocus();
    getDialog(
      child: DialogChild.alert(
        title: '更改密码',
        content: '是否确认要继续操作',
        onPressedRight: _sure,
        leftText: '取消',
        onPressedLeft: _cancel,
      ),
      autoBack: true,
    );
  }

  void _cancel() {
    Get.back();
  }

  void _sure() async {
    Get.back();
    getDialog();
    Map<String, dynamic> data = {
      'oldPassword': duMD5(oldController.text),
      'newPassword': duMD5(newOneController.text),
      'type': '1',
    };

    ResponseEntity responseEntity = await UserApi.setPassword(data);
    if (responseEntity.code == 200) {
      await futureMill(500);
      Get.back();
      Get.back();
      getSnackTop('密码修改成功', isError: false);
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  void handleReset() {
    /// 打开找回密码页面
    Get.bottomSheet(
      ForgotView(arguments: myController.userInfo),
      isScrollControlled: true, //全屏高度
      enableDrag: false, //下滑手势：关闭
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }

  void _textListener() {
    if (oldController.text.isEmpty) {
      state.isDissable = true;
    } else if (newOneController.text.isEmpty) {
      state.isDissable = true;
    } else if (newTwoController.text.isEmpty) {
      state.isDissable = true;
    } else if (newOneController.text != newTwoController.text) {
      state.isDissable = true;
    } else if (!isPassword(newOneController.text)) {
      state.isDissable = true;
    } else if (!isPassword(newTwoController.text)) {
      state.isDissable = true;
    } else {
      state.isDissable = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    oldFocusNode.requestFocus();
    oldController.addListener(() {
      _textListener();
    });
    newOneController.addListener(() {
      _textListener();
    });
    newTwoController.addListener(() {
      _textListener();
    });
  }

  @override
  void dispose() {
    oldController.dispose();
    oldFocusNode.dispose();
    newOneController.dispose();
    newOneFocusNode.dispose();
    newTwoController.dispose();
    newTwoFocusNode.dispose();
    super.dispose();
  }
}
