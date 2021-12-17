import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/dynamic.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Future getMediaView(ListElement item, {int? index, String? url}) {
  Widget child = GetBuilder<MediaViewController>(
    init: MediaViewController(),
    builder: (controller) {
      AppBar appBar = getAppBar(getSpan('text'));
      Widget mediaBox = Center(
        child: Container(
          width: double.infinity,
          height: 300,
          color: AppColors.mainColor,
        ),
      );
      Widget scaffold = Scaffold(
        body: getButton(
          child: mediaBox,
          onPressed: controller.handleOpcatiy,
          borderRadius: BorderRadius.zero,
          background: Colors.transparent,
        ),
        backgroundColor: AppColors.mainBacground,
      );
      return Stack(
        children: [
          scaffold,
          Column(
            children: [
              appBar,
            ],
          )
        ],
      );
    },
  );
  return getDialog(
    child: child,
  );
}
