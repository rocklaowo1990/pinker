import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:get/get.dart';

class InputType {
  static const String count = '手机号码或邮箱';
  static const String password = '密码';
}

Widget input({
  required String type,
  required TextEditingController controller,
  FocusNode? focusNode,
}) {
  bool isPassword = false;
  TextInputType keyboardType = TextInputType.emailAddress;
  RxString obs = controller.text.obs;
  void Function()? onPressed;

  void clearText() {
    controller.text = '';
    obs.value = controller.text;
  }

  void showText() {}

  void onChanged(String value) {
    obs.value = value;
  }

  switch (type) {
    case InputType.count:
      onPressed = clearText;
      break;
    case InputType.password:
      onPressed = showText;
      isPassword = true;
      keyboardType = TextInputType.visiblePassword;
      break;

    default:
  }

  IconButton suffixIcon = IconButton(
    onPressed: onPressed,
    icon: Icon(
      IconFont.delete,
      color: AppColors.inputHint,
      size: 9.w,
    ),
  );

  Obx textField = Obx(() {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          suffixIcon: obs.value.isEmpty ? null : suffixIcon,
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
      obscureText: isPassword,
      onChanged: onChanged,
    );
  });

  return textField;
}
