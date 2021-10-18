import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget bottomButton({
  VoidCallback? onPressedLeft,
  VoidCallback? onPressedRight,
  RxBool? loading,
  RxBool? disable,
  String? textLeft,
  String? textRight,
  String? textLeftSecond,
}) {
  /// 左侧组件初始化：默认是文本
  Widget leftWidget = span(text: textLeft, color: AppColors.mainColor);

  /// 右侧按钮初始化
  Widget rightWidget = buttonWidget(
    child: span(
      text: textRight,
      color: AppColors.mainText,
    ),
    width: 40.w,
    height: 18.h,
    onPressed: onPressedRight,
  );

  /// 右侧按钮 Loading 状态
  Widget buttonLoading = SizedBox(
    width: 10.h,
    height: 10.h,
    child: const CircularProgressIndicator(
      color: AppColors.mainText,
      strokeWidth: 2.0,
    ),
  );

  Widget _body(
    Widget left,
    Widget right,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      width: double.infinity,
      height: 25.h,
      color: AppColors.secondBacground,
      child: Row(
        children: [
          Expanded(child: left),
          const Spacer(),
          right,
        ],
      ),
    );
  }

  /// 如果
  if (loading != null && disable != null) {
    leftWidget = Obx(
      () => buttonWidget(
        onPressed: loading.value ? () {} : onPressedLeft,
        child: span(text: textLeft, color: AppColors.mainColor),
        background: Colors.transparent,
        alignment: Alignment.centerLeft,
        width: 80.w,
        height: 18.h,
      ),
    );
    rightWidget = Obx(
      () => buttonWidget(
          child: loading.value
              ? buttonLoading
              : span(
                  text: textRight,
                  color:
                      disable.value ? AppColors.secondText : AppColors.mainText,
                ),
          width: 40.w,
          height: 18.h,
          onPressed: loading.value ? () {} : onPressedRight,
          background: loading.value || disable.value
              ? AppColors.buttonDisable
              : AppColors.mainColor),
    );
    return _body(leftWidget, rightWidget);
  }

  /// 底部 bottom 布局
  return _body(leftWidget, rightWidget);
}
