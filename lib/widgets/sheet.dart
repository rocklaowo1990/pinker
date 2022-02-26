import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/values/colors.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Future getImage(VoidCallback handleCamera, VoidCallback handleGallery) async {
  await Get.bottomSheet(
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: GestureDetector(onTap: () {
              Get.back();
            }),
          ),
        ),
        Container(
          color: AppColors.mainBacground,
          padding: const EdgeInsets.all(40),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                _button(1, handleCamera),
                const SizedBox(height: 16),
                _button(2, handleGallery),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _button(int index, VoidCallback onPressed) {
  return getButton(
    child: getSpan(index == 1 ? '拍照' : '从相册里选取'),
    width: Get.width,
    // padding: EdgeInsets.only(top: 7, bottom: 7),
    height: 48,
    background: index == 1 ? AppColors.mainColor : AppColors.secondBacground,
    onPressed: onPressed,
  );
}
