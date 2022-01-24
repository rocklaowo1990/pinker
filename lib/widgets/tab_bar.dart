import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getTabBar(
  List<String> tabs,
  RxInt rxInt, {
  void Function(int)? onTap,
  TabController? controller,
}) {
  return SizedBox(
    width: tabs.length <= 1 ? 60.w : double.infinity,
    height: tabs.length <= 1 ? 56 : double.infinity,
    child: TabBar(
      labelPadding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      indicatorWeight: 2.w,
      tabs: tabs
          .asMap()
          .keys
          .map(
            (index) => Obx(
              () => getSpan(
                tabs[index],
                fontSize: 16.sp,
                color: rxInt.value == index
                    ? AppColors.mainColor
                    : AppColors.secondIcon,
                fontWeight: rxInt.value == index ? FontWeight.w600 : null,
              ),
            ),
          )
          .toList(),
      onTap: onTap,
      controller: controller,
      labelColor: Colors.transparent,
      unselectedLabelColor: Colors.transparent,
      automaticIndicatorColorAdjustment: false,
    ),
  );
}
