import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 中间弹出窗：默认是loading
Future<dynamic> getDialog({
  Widget? child,
  bool? autoBack,
  double? width,
  double? height,
  Color? barrierColor,
  Object? arguments,
}) async {
  Get.dialog(
    child ?? DialogChild.loading(),
    barrierDismissible: autoBack ?? false,
    barrierColor: barrierColor,
    arguments: arguments,
  );
}

/// 弹窗专用子组件
class DialogChild {
  /// loading
  static Widget loading({
    double? width,
    double? height,
  }) {
    return Center(
      child: Container(
        width: width ?? 40.w,
        height: height ?? 40.w,
        decoration: BoxDecoration(
          color: AppColors.secondBacground,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Center(
          child: SizedBox(
            width: 9.w,
            height: 9.w,
            child: CircularProgressIndicator(
              backgroundColor: AppColors.mainIcon,
              color: AppColors.mainColor,
              strokeWidth: 1.w,
            ),
          ),
        ),
      ),
    );
  }

  /// 中间弹出消息
  static Widget alert({
    double? width,
    double? height,
    Widget? child,
    VoidCallback? onPressedLeft,
    VoidCallback? onPressedRight,
    String? leftText,
    String? rightText,
  }) {
    return Center(
      child: Container(
        width: width ?? 120.w,
        height: height ?? 90.w,
        decoration: BoxDecoration(
          color: AppColors.secondBacground,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: child,
              ),
              flex: 1,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.5.h, color: AppColors.line),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: getButton(
                        child: Text(leftText ?? Lang.edit.tr),
                        width: double.infinity,
                        height: 25.h,
                        background: Colors.transparent,
                        radius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.w),
                        ),
                        onPressed: onPressedLeft),
                  ),
                  if (onPressedRight != null)
                    Container(
                      width: 0.5.w,
                      height: 25.h,
                      color: AppColors.line,
                    ),
                  if (onPressedRight != null)
                    Expanded(
                      child: getButton(
                        child: Text(rightText ?? Lang.sure.tr),
                        height: 25.h,
                        width: double.infinity,
                        background: Colors.transparent,
                        radius: BorderRadius.only(
                          bottomRight: Radius.circular(8.w),
                        ),
                        onPressed: onPressedRight,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 照片裁切
  static Widget imageCrop(XFile image, GlobalKey<CropState> key,
      {VoidCallback? onPressed}) {
    Widget _buildCropImage() {
      return Container(
        color: Colors.black,
        padding: EdgeInsets.only(bottom: 20.h),
        child: Crop(
          key: key,
          image: FileImage(File(image.path)),
          aspectRatio: 4.0 / 4.0,
          maximumScale: 4.0, //最大缩放比例
        ),
      );
    }

    return Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox(
            width: 187.5.w,
            height: 406.h,
            child: _buildCropImage(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getButton(
                    width: 40.w,
                    height: 18.h,
                    child: getSpan(Lang.cancel.tr),
                    onPressed: () {
                      Get.back();
                    },
                    background: AppColors.secondBacground),
                SizedBox(width: 10.w),
                getButton(
                  width: 40.w,
                  height: 18.h,
                  child: getSpan(Lang.sure.tr),
                  onPressed: onPressed ??
                      () {
                        Get.back();
                      },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
