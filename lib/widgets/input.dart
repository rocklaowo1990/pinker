import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:get/get.dart';

class InputType {
  static const String count = '手机号码、邮箱地址或账号';
  static const String password = '密码';
}

Widget input({
  required String type,
  required TextEditingController controller,
  FocusNode? focusNode,
  bool? autofocus,
  TextInputAction? textInputAction,
  void Function()? onEditingComplete,
}) {
  /// 判断是否是密码输入框
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
    FocusScope.of(Get.context!).requestFocus(focusNode);
  }

  /// 显示密码 和 隐藏密码
  void passwordText() {
    isPassword.value = !isPassword.value;
    FocusScope.of(Get.context!).requestFocus(focusNode);
    suffixIcon.value =
        isPassword.value ? Icons.visibility_off : Icons.visibility;
  }

  /// 文本改变事件
  void onChanged(String value) {
    textObs.value = value;
  }

  /// 根据不同的类型 初始化
  switch (type) {
    case InputType.count:
      onPressed = clearText;
      break;
    case InputType.password:
      onPressed = passwordText;
      isPassword.value = true;
      keyboardType = TextInputType.visiblePassword;
      suffixIcon.value = Icons.visibility_off;
      break;

    default:
  }

  /// 组件
  Obx textField = Obx(() {
    return TextField(
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          suffixIcon: textObs.value.isEmpty
              ? null
              : IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    suffixIcon.value,
                    color: AppColors.inputHint,
                    size: 9.w,
                  ),
                ),
          contentPadding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
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
            color: AppColors.darkText,
          )),
      style: TextStyle(fontSize: 8.sp, color: AppColors.white),
      obscureText: isPassword.value,
      onChanged: onChanged,
    );
  });

  return textField;
}
