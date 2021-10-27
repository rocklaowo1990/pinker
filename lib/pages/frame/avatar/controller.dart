import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinker/pages/frame/avatar/library.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/sheet.dart';
import 'package:pinker/widgets/widgets.dart';

class AvatarController extends GetxController {
  final FrameController frameController = Get.put(FrameController());
  final AvatarState state = AvatarState();

  final GlobalKey<CropState> cropKey = GlobalKey<CropState>();
  late File imageHeader;
  XFile? image;

  /// 添加头像按钮
  void handleGetImage() async {
    await getImage(_camera, _gallery);
  }

  void handleNotNow() {
    frameController.state.pageIndex = -3;

    Get.offAllNamed(AppRoutes.subscription, id: 1);
  }

  void handleNext() {
    frameController.state.pageIndex = -3;
    Get.offAllNamed(AppRoutes.subscription, id: 1);
  }

  void _camera() async {
    Get.back();
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      getDialog(
        child: dialogImage(image!, cropKey, onPressed: _imageResult),
        barrierColor: AppColors.mainBacground,
      );
    }
  }

  void _gallery() async {
    Get.back();
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      getDialog(
        child: dialogImage(image!, cropKey, onPressed: _imageResult),
        barrierColor: AppColors.mainBacground,
      );
    }
  }

  void _imageResult() async {
    final crop = cropKey.currentState;
    if (crop != null) {
      final area = crop.area;
      if (area != null) {
        await ImageCrop.requestPermissions().then((value) {
          if (value) {
            ImageCrop.cropImage(file: File(image!.path), area: crop.area!)
                .then((value) {
              state.image++;
              imageHeader = value;
            });
          }
        });
      }
    }

    Get.back();
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
