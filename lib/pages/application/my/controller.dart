import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/utils/utils.dart';

class MyController extends GetxController {
  final MyState state = MyState();
  final ScrollController scrollController = ScrollController();

  void handleLoginOut() {
    goLoginPage();
  }

  void handleMail() {}

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      state.opacity = scrollController.offset / 100;
      if (state.opacity > 1) state.opacity = 1;
      if (state.opacity < 0) state.opacity = 0;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}