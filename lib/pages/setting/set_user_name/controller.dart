import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/setting/set_user_name/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetUserNameController extends GetxController {
  final state = SetUserNameState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final ApplicationController applicationController = Get.find();

  @override
  void onReady() {
    super.onReady();

    focusNode.requestFocus();

    textController.addListener(() {
      String text = textController.text;
      if (isUserNameSenond(text)) {
        state.isDissable = false;
      } else {
        state.isDissable = true;
      }
    });
  }

  void _cancel() {
    Get.back();
  }

  void _editUserName() async {
    _cancel();
    getDialog();

    ResponseEntity responseEntity = await UserApi.setUserName(
      userName: textController.text,
    );

    if (responseEntity.code == 200) {
      // applicationController.state.userInfoMap['userName'] = textController.text;

      var _userInfo = await StorageUtil().getJSON(storageUserInfoKey);
      _userInfo['userName'] = textController.text;
      await StorageUtil().setJSON(storageUserInfoKey, _userInfo);

      await futureMill(500);
      Get.back();
      Get.back();
      getSnackTop('用户名修改成功', isError: false);
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  void handleSure() async {
    focusNode.unfocus();
    getDialog(
      child: DialogChild.alert(
        onPressedLeft: _cancel,
        onPressedRight: _editUserName,
        title: '修改用户名',
        content: '是否确认将用户名更换为${textController.text}',
        leftText: '取消',
      ),
      autoBack: true,
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }
}
