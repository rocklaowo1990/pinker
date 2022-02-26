import 'dart:io';

import 'package:flutter/material.dart';

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
  return Get.dialog(
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
        width: width ?? 80,
        height: height ?? 80,
        decoration: BoxDecoration(
          color: AppColors.secondBacground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              backgroundColor: AppColors.mainIcon,
              color: AppColors.mainColor,
              strokeWidth: 1.5,
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
            height: 48,
            child: Text(leftText ?? Lang.edit.tr),
            width: double.infinity,
            background: Colors.transparent,
            borderRadius: onPressedRight != null
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
            onPressed: onPressedLeft,
          ),
          flex: 1,
        ),
        if (onPressedRight != null)
          Container(
            width: 0.5,
            height: 48,
            color: AppColors.line,
          ),
        if (onPressedRight != null)
          Expanded(
            child: getButton(
              height: 48,
              child: Text(rightText ?? Lang.sure.tr),
              width: double.infinity,
              background: Colors.transparent,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
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
        const SizedBox(height: 20),
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        color: AppColors.secondBacground,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: 24,
            ),
            child: contentBox,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.line),
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
          padding: const EdgeInsets.all(64),
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
        padding: const EdgeInsets.only(bottom: 20),
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
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: getButton(
                      width: Get.width,
                      height: 48,
                      child: getSpan(Lang.cancel.tr),
                      onPressed: () {
                        Get.back();
                      },
                      background: AppColors.secondBacground),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: getButton(
                    width: Get.width,
                    height: 48,
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
