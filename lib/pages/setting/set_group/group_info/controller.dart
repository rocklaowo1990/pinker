import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/api/subscribe_group.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/group_list.dart';

import 'package:pinker/pages/setting/set_group/group_info/library.dart';
import 'package:pinker/pages/setting/set_group/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/sheet.dart';
import 'package:pinker/widgets/widgets.dart';

class SetGroupInfoController extends GetxController {
  final state = SetGroupInfoState();

  final GroupInfoEntities? arguments = Get.arguments;

  final GlobalKey<CropState> cropKey = GlobalKey<CropState>();
  late File avatarFile;
  XFile? image;

  TextEditingController textEditingGroupName = TextEditingController();
  FocusNode focusGroupName = FocusNode();

  TextEditingController textEditingPrice = TextEditingController();
  FocusNode focusPrice = FocusNode();

  void _cancel() {
    Get.back();
  }

  void _sure() async {
    Get.back();

    /// Loading弹窗
    getDialog();

    /// 头像地址
    String avatarUrl = '';

    if (state.image > 0) {
      /// 获取文件的MD5
      Digest flieMD5 = md5.convert(avatarFile.readAsBytesSync());

      /// 获取token
      String token = await StorageUtil().getJSON(storageUserTokenKey);

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
        /// 验证的时候，如果返回的url是空，代表这个图片是新的，可以上传
        if (verifyResource.data['url'] == '') {
          /// 开始上传
          ResponseEntity uploadFile = await CommonApi.uploadFile(
            fileName: '$flieMD5.jpg',
            filePath: avatarFile.path,
            type: '1',
            token: token,
          );

          /// 上传结果
          if (uploadFile.code == 200) {
            avatarUrl = uploadFile.data['url'];
          } else {
            getSnackTop(uploadFile.msg);
          }
        } else {
          avatarUrl = verifyResource.data['url'];
        }

        /// 资源验证结果
        /// 失败
      } else {
        Get.back();
        getSnackTop(verifyResource.msg);
        return;
      }
    }

    /// 开始修改
    ResponseEntity updateGroupInfo = arguments != null
        ? await SubscribeGroupApi.update(
            groupId: arguments!.groupId,
            groupName: textEditingGroupName.text != arguments!.groupName
                ? textEditingGroupName.text
                : arguments!.groupName,
            groupPic: state.image > 0 ? avatarUrl : arguments!.groupPic,
            amount: double.parse(textEditingPrice.text) != arguments!.amount
                ? double.parse(textEditingPrice.text)
                : arguments!.amount,
          )
        : await SubscribeGroupApi.create(
            groupName: textEditingGroupName.text,
            groupPic: avatarUrl,
            amount: textEditingPrice.text,
          );

    /// 修改结果
    if (updateGroupInfo.code == 200) {
      final SetGroupController setGroupController = Get.find();
      setGroupController.response();
      await futureMill(500);
      Get.back();
      Get.back();
    } else {
      await futureMill(500);
      Get.back();
      getSnackTop(updateGroupInfo.msg);
    }
  }

  void handleSure() async {
    focusGroupName.unfocus();
    focusPrice.unfocus();
    getDialog(
      child: DialogChild.alert(
        onPressedLeft: _cancel,
        onPressedRight: _sure,
        title: arguments != null ? '修改订阅组' : '添加订阅组',
        content: '是否确认继续操作',
        leftText: '取消',
      ),
      autoBack: true,
    );
  }

  /// 添加头像按钮
  void handleGetImage() async {
    focusGroupName.unfocus();
    focusPrice.unfocus();
    await getImage(_camera, _gallery);
  }

  /// 相机获取照片并裁切
  void _camera() async {
    Get.back();
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      getDialog(
        child: DialogChild.imageCrop(image!, cropKey, onPressed: _imageResult),
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
    if (arguments != null) {
      textEditingGroupName.text = arguments!.groupName;
      textEditingPrice.text = arguments!.amount.toString();
    }
    super.onInit();
  }

  void _linstenerEdit() {
    if (textEditingPrice.text.isEmpty) {
      state.isDissable = true;
    } else if (arguments != null &&
        textEditingGroupName.text == arguments!.groupName &&
        double.parse(textEditingPrice.text) == arguments!.amount &&
        state.image <= 0) {
      state.isDissable = true;
    } else if (!getGroupName(textEditingGroupName.text)) {
      state.isDissable = true;
    } else if (textEditingGroupName.text.length <= 2 ||
        textEditingGroupName.text.length > 7 ||
        textEditingPrice.text.isEmpty) {
      state.isDissable = true;
    } else {
      state.isDissable = false;
    }
  }

  void _linstenerAdd() {
    if (textEditingGroupName.text.length <= 2 ||
        textEditingGroupName.text.length > 7) {
      state.isDissable = true;
    } else if (textEditingPrice.text.isEmpty) {
      state.isDissable = true;
    } else if (state.image <= 0) {
      state.isDissable = true;
    } else if (!getGroupName(textEditingGroupName.text)) {
      state.isDissable = true;
    } else {
      state.isDissable = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (arguments != null) {
      textEditingGroupName.addListener(() {
        _linstenerEdit();
      });

      textEditingPrice.addListener(() {
        _linstenerEdit();
      });

      ever(state.imageRx, (value) {
        state.isDissable = false;
      });
    } else {
      textEditingGroupName.addListener(() {
        _linstenerAdd();
      });

      textEditingPrice.addListener(() {
        _linstenerAdd();
      });

      ever(state.imageRx, (value) {
        _linstenerAdd();
      });
    }
  }

  @override
  void dispose() {
    focusGroupName.dispose();
    focusPrice.dispose();
    textEditingGroupName.dispose();
    textEditingPrice.dispose();
    super.dispose();
  }
}
