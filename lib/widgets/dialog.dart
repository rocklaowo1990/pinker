import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 中间弹出窗：默认是loading
/// 中间弹出通用
Future<Widget?> getDialog({
  Widget? child,
  bool autoBack = false,
  double? width,
  double? height,
  Color color = Colors.transparent,
  Object? arguments,
}) async {
  Get.dialog(
    Material(
      child: child ?? DialogChild.loading(),
      color: color,
    ),
    barrierDismissible: autoBack,
    arguments: arguments,
    useSafeArea: false,
  );
}

/// 弹窗专用子组件
/// 这里的组件只供弹窗使用
/// 可以调用里面的静态组件
class DialogChild {
  /// loading
  static Widget loading({
    double? width,
    double? height,
  }) {
    return Center(
      child: Container(
        width: width ?? 80.w,
        height: height ?? 80.w,
        decoration: BoxDecoration(
          color: AppColors.secondBacground,
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: Center(
          child: SizedBox(
            width: 16.w,
            height: 16.w,
            child: CircularProgressIndicator(
              backgroundColor: AppColors.mainIcon,
              color: AppColors.mainColor,
              strokeWidth: 1.5.w,
            ),
          ),
        ),
      ),
    );
  }

  /// 中间弹出消息 ////////////////////////////////////////////////////////
  static Widget alert({
    String? title,
    String? content,
    Widget? contentWidget,
    VoidCallback? onPressedLeft,
    VoidCallback? onPressedRight,
    String? leftText,
    String? rightText,
  }) {
    /// 底部的按钮
    Widget buttonBox = Row(
      children: [
        Expanded(
          child: getButton(
            height: 40.h,
            child: Text(leftText ?? Lang.edit.tr),
            width: double.infinity,
            background: Colors.transparent,
            borderRadius: onPressedRight != null
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(16.w),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(16.w),
                    bottomRight: Radius.circular(16.w),
                  ),
            onPressed: onPressedLeft,
          ),
          flex: 1,
        ),
        if (onPressedRight != null)
          Container(
            width: 0.5.w,
            height: 40.h,
            color: AppColors.line,
          ),
        if (onPressedRight != null)
          Expanded(
            child: getButton(
              height: 40.h,
              child: Text(rightText ?? Lang.sure.tr),
              width: double.infinity,
              background: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16.w),
              ),
              onPressed: onPressedRight,
            ),
            flex: 1,
          ),
      ],
    );

    /// 内容区
    Widget contentBox = Column(
      children: [
        getSpanTitle(title ?? ''),
        SizedBox(height: 20.h),
        contentWidget ??
            getSpan(
              content,
              color: AppColors.secondText,
              textAlign: TextAlign.center,
            ),
      ],
    );

    /// 整体组装
    Widget body = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16.w),
        ),
        color: AppColors.secondBacground,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 24.h,
              bottom: 24.h,
            ),
            child: contentBox,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5.h, color: AppColors.line),
              ),
            ),
            child: buttonBox,
          ),
        ],
      ),
    );

    return Stack(
      children: [
        getButton(
            background: Colors.transparent,
            overlayColor: Colors.transparent,
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            onPressed: () {
              Get.back();
            }),
        Padding(
          padding: EdgeInsets.all(64.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              body,
              const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  /// 照片裁切 ////////////////////////////////////////////////////////
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
            width: double.infinity,
            height: double.infinity,
            child: _buildCropImage(),
          ),
          Padding(
            padding: EdgeInsets.all(20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: getButton(
                      width: Get.width,
                      height: 40.h,
                      child: getSpan(Lang.cancel.tr),
                      onPressed: () {
                        Get.back();
                      },
                      background: AppColors.secondBacground),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: getButton(
                    width: Get.width,
                    height: 40.h,
                    child: getSpan(Lang.sure.tr),
                    onPressed: onPressed ??
                        () {
                          Get.back();
                        },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
