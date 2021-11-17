import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/application/home/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 顶部左侧
    Widget left = Container(
      child: getSpan(
        '订阅',
        fontSize: 17,
        color: AppColors.mainColor,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.6.w, color: AppColors.mainColor),
        ),
      ),
    );

    Widget right = getButton(
      child: SvgPicture.asset(
        'assets/svg/icon_mail_3.svg',
      ),
      background: Colors.transparent,
      width: 33.h,
      height: 33.h,
      onPressed: controller.handleMail,
    );

    /// AppBar
    AppBar appBar = getMainBar(
      left: left,
      right: right,
    );

    /// body
    Widget body = Center(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          SvgPicture.asset(
            'assets/svg/error_4.svg',
            width: 55.w,
          ),
          SizedBox(height: 6.h),
          getSpan('暂无数据', color: AppColors.secondText),
        ],
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
