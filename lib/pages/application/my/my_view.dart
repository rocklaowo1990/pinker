import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class MyView extends GetView<MyController> {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// AppBar
    AppBar appBar = getAppBar(
      getSpan('My'),
      elevation: 0.5.w,
      backgroundColor: AppColors.mainBacground,
    );

    /// body
    Widget body = SizedBox(
      child: Center(
        child: getButton(
          child: getSpan('退出登陆'),
          width: 100.w,
          height: 26.h,
          onPressed: () {
            goLoginPage();
          },
        ),
      ),
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
