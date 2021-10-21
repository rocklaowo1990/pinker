import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool? autofocus,

  /// 键盘右下角的按钮类型
  TextInputAction? textInputAction,

  /// padding
  EdgeInsetsGeometry? contentPadding,

  /// 左侧按钮
  Widget? prefixIcon,
}) {
  /// 判断是否显示密码
  RxBool isPassword = false.obs;

  /// 根据不同的类型给予不同的键盘类型
  TextInputType keyboardType = TextInputType.emailAddress;

  /// 右侧按钮状态管理
  RxString textObs = controller.text.obs;

  /// 右侧按钮图标
  Rx<IconData> suffixIcon = IconFont.delete.obs;

  /// 右侧按钮点击事件
  void Function()? onPressed;

  /// 清除文本
  void clearText() {
    controller.text = '';
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

  /// 根据不同的类型 初始化
  if (type == Lang.inputPassword.tr) {
    onPressed = passwordText;
    isPassword.value = true;
    keyboardType = TextInputType.visiblePassword;
    suffixIcon.value = Icons.visibility_off;
  } else {
    onPressed = clearText;
  }

  /// 组件
  Widget textField = Obx(() {
    return TextField(
      textInputAction: textInputAction,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: textObs.value.isEmpty
              ? null
              : IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    suffixIcon.value,
                    color: AppColors.inputHint,
                    size: 8.sp,
                  ),
                ),
          contentPadding:
              contentPadding ?? EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
          filled: true,
          fillColor: AppColors.inputFiled,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(187.5.w),
            ),
            borderSide: BorderSide.none,
          ),
          hintText: type,
          hintStyle: TextStyle(
            fontSize: 8.sp,
            color: AppColors.secondText,
          )),
      style: TextStyle(fontSize: 8.sp, color: AppColors.mainText),
      obscureText: isPassword.value,
      onChanged: onChanged,
    );
  });

  return textField;
}
