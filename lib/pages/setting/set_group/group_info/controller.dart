import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pinker/pages/setting/set_group/group_info/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/sheet.dart';
import 'package:pinker/widgets/widgets.dart';

class SetGroupInfoController extends GetxController {
  final state = SetGroupInfoState();

  final arguments = Get.arguments;

  final GlobalKey<CropState> cropKey = GlobalKey<CropState>();
  late File avatarFile;
  XFile? image;

  TextEditingController textEditingGroupName = TextEditingController();
  FocusNode focusGroupName = FocusNode();

  TextEditingController textEditingPrice = TextEditingController();
  FocusNode focusPrice = FocusNode();

  void handleSure() {}

  /// 添加头像按钮
  void handleGetImage() async {
    await getImage(_camera, _gallery);
  }

  /// 相机获取照片并裁切
  void _camera() async {
    Get.back();
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      getDialog(
        child: DialogChild.imageCrop(image!, cropKey, onPressed: _imageResult),
        barrierColor: AppColors.mainBacground,
      );
    }
  }

  /// 相册获取照片并裁切
  void _gallery() async {
    Get.back();
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      getDialog(
        child: DialogChild.imageCrop(image!, cropKey, onPressed: _imageResult),
        barrierColor: AppColors.mainBacground,
      );
    }
  }

  /// 裁切后的照片
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
              avatarFile = value;
            });
          }
        });
      }
    }

    Get.back();
  }

  @override
  void onInit() {
    if (arguments != 1) {
      textEditingGroupName.text = arguments['groupName'];
      textEditingPrice.text = '${arguments['amount']}';
    }
    super.onInit();
  }
}
