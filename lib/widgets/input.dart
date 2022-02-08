import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getInput({
  /// 键盘的类型
  required String type,

  /// 控制器
  required TextEditingController controller,

  /// 焦点
  required FocusNode focusNode,

  /// 是否自动获取焦点
  // bool autofocus = false,

  /// 键盘右下角的按钮类型
  TextInputAction? textInputAction,

  /// 左侧按钮
  Widget? prefixIcon,

  /// 输入框宽度
  double? width,

  /// 输入框高度
  double? height,

  /// padding
  EdgeInsetsGeometry? contentPadding,

  /// radius
  BorderRadius? borderRadius,
  void Function(String)? onSubmitted,
  int? maxLines = 1,
}) {
  /// 判断是否显示密码
  RxBool isPassword = false.obs;

  /// 根据不同的类型给予不同的键盘类型
  TextInputType keyboardType = TextInputType.emailAddress;

  /// 右侧按钮状态管理
  RxString textObs = controller.text.obs;

  /// 右侧按钮图标
  Rx<IconData> suffixIcon = Icons.cancel.obs;

  /// 右侧按钮点击事件
  void Function()? onPressed;

  /// 清除文本
  void clearText() {
    controller.clear();
    textObs.value = controller.text;
    focusNode.requestFocus();
  }

  /// 显示密码 和 隐藏密码
  void passwordText() {
    isPassword.value = !isPassword.value;
    focusNode.requestFocus();
    suffixIcon.value =
        isPassword.value ? Icons.visibility_off : Icons.visibility;
  }

  /// 文本改变事件
  void onChanged(String value) {
    textObs.value = value;
  }

  controller.addListener(() {
    textObs.value = controller.text;
  });

  onPressed = clearText;

  /// 根据不同的类型 初始化
  if (RegExp(r"密码").hasMatch(type)) {
    onPressed = passwordText;
    isPassword.value = true;
    keyboardType = TextInputType.visiblePassword;
    suffixIcon.value = Icons.visibility_off;
  } else if (type == Lang.inputPhone.tr || RegExp(r"数量").hasMatch(type)) {
    keyboardType = TextInputType.number;
  } else if (type == Lang.inputEmail.tr) {
    keyboardType = TextInputType.emailAddress;
  } else if (RegExp(r"新鲜事").hasMatch(type)) {
    keyboardType = TextInputType.multiline;
  }

  /// 组件
  Widget textField = Obx(() {
    return TextField(
      cursorColor: AppColors.mainColor,
      textInputAction: textInputAction,
      // autofocus: autofocus,
      focusNode: focusNode,
      controller: controller,
      onSubmitted: onSubmitted,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: textObs.value.isEmpty
            ? null
            : getButton(
                child: Icon(
                  suffixIcon.value,
                  color: AppColors.inputHint,
                  size: 16.sp,
                ),
                onPressed: onPressed,
                background: AppColors.inputFiled,
                width: 20.w,
                height: 20.w,
              ),
        contentPadding: contentPadding ?? EdgeInsets.only(left: 20.w),
        border: OutlineInputBorder(
          borderRadius: borderRadius ??
              BorderRadius.all(
                Radius.circular(Get.width),
              ),
          borderSide: BorderSide.none,
        ),
        hintText: type,
        hintStyle: TextStyle(
          color: AppColors.secondText,
          fontSize: 14.sp,
        ),
      ),
      style: TextStyle(color: AppColors.mainText, fontSize: 14.sp),
      obscureText: isPassword.value,
      onChanged: onChanged,
    );
  });

  return Container(
    child: Center(
      child: textField,
    ),
    width: width,
    height: height ?? 48.h,
    decoration: BoxDecoration(
        color: AppColors.inputFiled,
        borderRadius:
            borderRadius ?? BorderRadius.all(Radius.circular(Get.width))),
  );
}

Widget getSearchInput(
  TextEditingController controller,
  FocusNode focusNode, {
  BorderRadius? borderRadius,
  // Widget? prefixIcon,
  void Function(String)? onSubmitted,
}) {
  return getInput(
    height: 48.h,
    contentPadding: EdgeInsets.only(left: 20.w),
    type: Lang.inputSearch.tr,
    controller: controller,
    focusNode: focusNode,
    borderRadius: borderRadius,
    onSubmitted: onSubmitted,
    textInputAction: TextInputAction.search,
    prefixIcon: SizedBox(
      width: 10.h,
      height: 10.h,
      child: Center(
        child: SvgPicture.asset(
          'assets/svg/icon_search_2.svg',
        ),
      ),
    ),
  );
}
