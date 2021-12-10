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
  }

  /// 组件
  Widget textField = Obx(() {
    return TextField(
      cursorColor: AppColors.mainColor,
      textInputAction: textInputAction,
      // autofocus: autofocus,
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: textObs.value.isEmpty
              ? null
              : getButton(
                  child: Icon(
                    suffixIcon.value,
                    color: AppColors.inputHint,
                    size: 9.sp,
                  ),
                  onPressed: onPressed,
                  background: AppColors.inputFiled,
                  width: 26.w,
                ),
          contentPadding: contentPadding ??
              EdgeInsets.only(
                left: 10.w,
                top: 8.h,
                bottom: 8.h,
              ),
          filled: true,
          fillColor: AppColors.inputFiled,
          border: OutlineInputBorder(
            borderRadius: borderRadius ??
                BorderRadius.all(
                  Radius.circular(187.5.w),
                ),
            borderSide: BorderSide.none,
          ),
          hintText: type,
          hintStyle: const TextStyle(
            color: AppColors.secondText,
            fontSize: 15,
          )),
      style: const TextStyle(color: AppColors.mainText, fontSize: 15),
      obscureText: isPassword.value,
      onChanged: onChanged,
    );
  });

  return SizedBox(
    child: Center(
      child: textField,
    ),
    width: width,
    height: height,
  );
}

Widget getSearchInput(
  TextEditingController controller,
  FocusNode focusNode,
) {
  return getInput(
    height: 40,
    contentPadding: EdgeInsets.only(left: 8.w),
    type: Lang.inputSearch.tr,
    controller: controller,
    focusNode: focusNode,
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
