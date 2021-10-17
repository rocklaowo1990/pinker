import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget bottomButton({
  VoidCallback? onPressedLeft,
  VoidCallback? onPressedRight,
  required RxBool disable,
  required String textLeft,
  String? textLeftSecond,
  required String textRight,
}) {
  /// 左侧按钮1
  var leftButton = Obx(() => buttonWidget(
        onPressed: disable.value ? () {} : onPressedLeft,
        text: textLeft,
        background: Colors.transparent,
        textColor: AppColors.mainColor,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 5.w),
      ));

  var leftText = Text(
    textLeft,
    style: TextStyle(
      color: AppColors.mainColor,
      fontSize: 8.sp,
    ),
  );

  /// 右侧按钮
  var rightButton = buttonWidget(
    onPressed: onPressedRight ?? () {},
    width: 40.w,
    height: 18.h,
    text: textRight,
  );

  /// 登陆按钮禁用状态
  var loginButtonDisable = Container(
    width: 40.w,
    height: 18.h,
    decoration: BoxDecoration(
      color: AppColors.buttonDisable,
      borderRadius: BorderRadius.all(Radius.circular(187.5.w)),
    ),
    child: Center(
      child: SizedBox(
        width: 10.h,
        height: 10.h,
        child: const CircularProgressIndicator(
          color: AppColors.mainText,
          strokeWidth: 2.0,
        ),
      ),
    ),
  );

  /// 底部 bottom 布局
  return Container(
    padding: EdgeInsets.only(left: 5.w, right: 5.w),
    width: double.infinity,
    height: 25.h,
    color: AppColors.secondBacground,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: onPressedLeft == null ? leftText : leftButton),
        const Spacer(),
        Obx(
          () => disable.value ? loginButtonDisable : rightButton,
        ),
      ],
    ),
  );
}
