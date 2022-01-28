import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/library.dart';

class PublishController extends GetxController {
  final textController = TextEditingController();
  final ApplicationController applicationController = Get.find();
  @override
  void onReady() {
    super.onReady();
    textController.addListener(() {
      applicationController.state.publish.update((val) {
        val!.content = textController.text;
      });
    });
  }

  @override
  void onClose() {
    applicationController.state.publish.update((val) {
      val!.content = '';
      val.pics = '';
      val.video = '';
    });
    super.onClose();
  }
}
