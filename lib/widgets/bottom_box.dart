import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:get/get.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 这是有键盘的时候，底部的那一条功能条
/// 常用的地方有注册页面的底部
/// 例如登陆页面的底部
Widget getBottomBox({
  Widget? leftWidget,
  Widget? rightWidget,
}) {
  /// 左侧初始化
  Widget left = SizedBox(
    width: 10.w,
    height: 10.h,
  );

  /// 右侧按钮初始化
  Widget right = getButton(
    child: getSpan(
      Lang.sure.tr,
      color: AppColors.mainText,
    ),
    padding: EdgeInsets.only(left: 12.w, right: 12.w),
  );

  /// 底部 bottom 布局
  return Container(
    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.5.w, bottom: 2.5.w),
    width: double.infinity,
    height: 25.h,
    color: AppColors.secondBacground,
    child: Row(
      children: [
        leftWidget ?? left,
        const Spacer(),
        rightWidget ?? right,
      ],
    ),
  );
}
