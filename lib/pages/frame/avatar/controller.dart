import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:pinker/pages/frame/avatar/library.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/widgets/sheet.dart';

class AvatarController extends GetxController {
  final FrameController frameController = Get.put(FrameController());
  final FocusNode passwordFocusNode = FocusNode();
  final state = AvatarState();
  final cropKey = GlobalKey<CropState>();

  void handleGetImage() async {
    await getImage();
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
