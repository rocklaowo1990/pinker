import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 中间弹出窗：默认是loading ////////////////////////////////////////////////////
Future<dynamic> getDialog({
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

/// 弹窗专用子组件 ////////////////////////////////////////////////////////
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

  /// 中间弹出消息 ////////////////////////////////////////////////////////
  static Widget alert({
    String? title,
    String? content,
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
            height: 22.w,
            child: Text(leftText ?? Lang.edit.tr),
            width: double.infinity,
            background: Colors.transparent,
            borderRadius: onPressedRight != null
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(8.w),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(8.w),
                    bottomRight: Radius.circular(8.w),
                  ),
            onPressed: onPressedLeft,
          ),
          flex: 1,
        ),
        if (onPressedRight != null)
          Container(
            width: 0.5.w,
            height: 22.w,
            color: AppColors.line,
          ),
        if (onPressedRight != null)
          Expanded(
            child: getButton(
              height: 22.w,
              child: Text(rightText ?? Lang.sure.tr),
              width: double.infinity,
              background: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8.w),
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
        getSpan(title, fontSize: 17),
        SizedBox(height: 8.h),
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
          Radius.circular(8.w),
        ),
        color: AppColors.secondBacground,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 15.w,
              bottom: 15.w,
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

    return Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            body,
            const SizedBox(),
          ],
        ));
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
