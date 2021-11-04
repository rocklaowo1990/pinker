import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinker/api/common.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/frame/avatar/library.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/sheet.dart';
import 'package:pinker/widgets/widgets.dart';

class AvatarController extends GetxController {
  final FrameController frameController = Get.find();
  final AvatarState state = AvatarState();

  final GlobalKey<CropState> cropKey = GlobalKey<CropState>();
  late File avatarFile;
  XFile? image;

  /// 添加头像按钮
  void handleGetImage() async {
    await getImage(_camera, _gallery);
  }

  void handleNotNow() {
    frameController.state.pageIndex--; // 下一页不需要返回
    Get.offAllNamed(AppRoutes.subscription, id: 1);
  }

  void handleNext() async {
    /// Loading弹窗
    getDialog(autoBack: true);

    /// 获取文件的MD5
    Digest flieMD5 = md5.convert(avatarFile.readAsBytesSync());

    /// 获取token
    var _profileJSON = StorageUtil().getJSON(storageUserProfileKey);
    String token = _profileJSON['data']['token'];

    /// 准备验证资源
    Map<String, dynamic> verifyResourceData = {
      'fileName': '$flieMD5.jpg',
      'code': flieMD5,
    };

    /// 开始验证资源
    ResponseEntity verifyResource = await CommonApi.verifyResource(
      verifyResourceData,
      token: token,
    );

    /// 资源验证结果
    /// 成功
    if (verifyResource.code == 200) {
      /// 准备上传头像
      Map<String, dynamic> uploadData = {
        'file': MultipartFile(
          avatarFile, //这是一个显示在界面上的图片文件
          filename: '$flieMD5.jpg',
        ),
        'type': '1',
      };

      /// 开始上传
      ResponseEntity uploadFile = await CommonApi.uploadFile(
        uploadData,
        token: token,
      );

      /// 上传结果
      if (uploadFile.code == 200) {
        print(uploadFile.data.toString());
      } else {
        getSnackTop(uploadFile.msg);
      }

      /// 验证失败
    } else {
      getSnackTop(verifyResource.msg);
    }

    // frameController.state.pageIndex--; // 下一页不需要返回
    // Get.offAllNamed(AppRoutes.subscription, id: 1);
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
  void onInit() async {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 200), () {
      /// 提示注册成功
      getSnackTop(
        '注册成功',
        iconData: Icons.check_circle,
        iconColor: Colors.green,
      );
    });
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
