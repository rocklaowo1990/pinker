import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinker/pages/index/index.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logo = Icon(
      IconFont.logo,
      size: 18.w,
      color: AppColors.main,
    );

    var appBar = Container(
      padding: EdgeInsets.only(top: 16.h),
      width: double.infinity,
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: controller.handleGoSignBeforePage,
              icon: const Icon(Icons.precision_manufacturing)),
          logo,
          const Icon(Icons.precision_manufacturing),
        ],
      ),
    );

    var body = Navigator(
      key: Get.nestedKey(1),
      initialRoute: '/signBefore',
      onGenerateRoute: controller.onGenerateRoute,
    );

    var scaffold = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.linearGradientContainer,
      ),
      child: Column(
        children: [
          appBar,
          Expanded(
            child: body,
            flex: 1,
          ),
        ],
      ),
    );

    return Scaffold(
      body: scaffold,
    );
  }
}
