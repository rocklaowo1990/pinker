import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/password/state.dart';

class PasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final FrameController frameController = Get.put(FrameController());
  final FocusNode passwordFocusNode = FocusNode();
  final state = PasswordState();
}
