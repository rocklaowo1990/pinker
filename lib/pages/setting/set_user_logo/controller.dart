import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/response.dart';

import 'package:pinker/pages/setting/set_user_logo/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class SetUserLogoController extends GetxController {
  final state = SetUserLogoState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool enable = false;
  String text = '';

  /// 输入框文本监听
  void _textListener() {
    if (textController.text.isEmpty || textController.text.length > 7) {
      state.isDissable = true;
    } else if (textController.text == text && state.enable == enable) {
      state.isDissable = true;
    } else {
      state.isDissable = false;
    }
  }

  void handleOnChanged(value) {
    state.enable = value;
    _textListener();
  }

  void handleOnChangedNoValue() {
    state.enable = !state.enable;
  }

  void _response() async {
    ResponseEntity responseEntity = await UserApi.getUserLogo();
    if (responseEntity.code == 200) {
      state.isDissable = true;

      await futureMill(300);

      text = responseEntity.data['text'];
      enable = responseEntity.data['enable'];
      state.enable = enable;
      textController.text = text;
      state.isLoading = false;
    } else {
      await futureMill(300);
      getSnackTop(responseEntity.msg);
      state.isLoading = false;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    _response();
    textController.addListener(() {
      _textListener();
    });
  }

  void handleSure() async {
    focusNode.unfocus();

    /// 下一步按钮，点击事件
    getDialog(
      child: DialogChild.alert(
        onPressedLeft: _cancel,
        onPressedRight: _sure,
        title: '水印设置',
        content: '是否确认继续操作',
        leftText: '取消',
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
      'enable': state.enable ? 1 : 2,
      'text': textController.text,
    };
    ResponseEntity responseEntity = await UserApi.setUserLogo(data);
    if (responseEntity.code == 200) {
      await futureMill(500);
      Get.back();
      _response();
      getSnackTop('水印设置成功', isError: false);
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(responseEntity.msg);
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }
}
