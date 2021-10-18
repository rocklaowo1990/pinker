import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/values/values.dart';

class SettingView extends GetView<FrameController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
