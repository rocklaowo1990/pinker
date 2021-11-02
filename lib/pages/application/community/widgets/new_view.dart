import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/community/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class NewView extends GetView<CommunityController> {
  const NewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// body
    Widget body = Center(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          SvgPicture.asset(
            'assets/svg/tp_myssjg.svg',
            width: 55.w,
          ),
          SizedBox(height: 6.h),
          getSpan('暂无数据', color: AppColors.secondText),
        ],
      ),
    );
    return Scaffold(
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
