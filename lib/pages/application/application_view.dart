import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:pinker/pages/application/index.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ApplicationView'),
      ),
      body: Center(
        child: Column(
          children: [
            buttonWidget(
              onPressed: goLoginPage,
              text: '退出登陆',
              width: 100.w,
            ),
            buttonWidget(
              onPressed: () {
                var locale = const Locale('en', 'US');
                Get.updateLocale(locale);
              },
              text: '改变语言',
              width: 100.w,
            ),
          ],
        ),
      ),
    );
  }
}
