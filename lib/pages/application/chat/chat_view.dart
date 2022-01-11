import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/chat/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        /// AppBar
        AppBar appBar = getSearchBar(
          controller: controller.textController,
          focusNode: controller.focusNode,
        );

        /// body
        Widget body = Center(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              SvgPicture.asset(
                'assets/svg/error_1.svg',
                width: 55.w,
              ),
              SizedBox(height: 6.h),
              getSpan('暂无数据', color: AppColors.secondText),
            ],
          ),
        );

        /// 页面
        return Scaffold(
          backgroundColor: AppColors.mainBacground,
          appBar: appBar,
          body: body,
        );
      },
    );
  }
}
