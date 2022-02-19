import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/publish/state.dart';
import 'package:pinker/routes/routes.dart';

class PublishController extends GetxController {
  final textController = TextEditingController();
  final state = PublishState();
  final ApplicationController applicationController = Get.find();

  void handleReply() {
    Get.toNamed(AppRoutes.application + AppRoutes.publish + AppRoutes.reply);
  }

  @override
  void onReady() {
    super.onReady();
    textController.addListener(() {
      state.publish.update((val) {
        val!.content = textController.text;
      });
    });
  }
}
