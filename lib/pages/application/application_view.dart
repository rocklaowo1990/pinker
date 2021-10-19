import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
            getButton(
              onPressed: goLoginPage,
              child: const Text('data'),
              width: 100.w,
            ),
            getButton(
              onPressed: () {
                var locale = const Locale('en', 'US');
                Get.updateLocale(locale);
              },
              child: const Text('data'),
              width: 100.w,
            ),
          ],
        ),
      ),
    );
  }
}
