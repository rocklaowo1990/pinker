import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/password/state.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class AvatarController extends GetxController {
  final FrameController frameController = Get.put(FrameController());
  final FocusNode passwordFocusNode = FocusNode();
  final state = PasswordState();

  void handleGetImage() async {
    await Get.bottomSheet(
      Container(
        height: 120.h,
        color: AppColors.mainBacground,
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            getButton(
                child: getSpan('text'),
                width: double.infinity,
                onPressed: () async {
                  // var image =
                  //     await ImagePicker.pickImage(source: ImageSource.camera);
                }),
            SizedBox(height: 10.h),
            getButton(
                child: getSpan('text'),
                width: double.infinity,
                background: AppColors.secondBacground,
                onPressed: () async {
                  // var image =
                  //     await ImagePicker.pickImage(source: ImageSource.camera);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    frameController.dispose();
    super.dispose();
  }
}
