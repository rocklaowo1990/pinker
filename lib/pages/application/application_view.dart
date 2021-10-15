import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinker/pages/application/index.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ApplicationView'),
      ),
      body: const Center(
        child: IconButton(
          icon: Icon(Icons.home),
          color: AppColors.main,
          onPressed: goLoginPage,
        ),
      ),
    );
  }
}
