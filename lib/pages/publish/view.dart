import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/publish/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class PublishView extends GetView<PublishController> {
  const PublishView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var input = TextField(
      controller: controller.textController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autofocus: true,
      style: TextStyle(color: AppColors.mainText, fontSize: 14.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.w),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        fillColor: AppColors.inputFiled,
        filled: true,
        hintText: '有什么新鲜事?',
        hintStyle: const TextStyle(color: AppColors.secondText),
        counterStyle: const TextStyle(color: AppColors.mainText),
      ),
      maxLength: 200,
    );

    var appBar = getAppBar(
      getSpanTitle('发推'),
      backgroundColor: AppColors.secondBacground,
      actions: [
        Obx(() => controller.applicationController.state.publish.value.content
                    .isEmpty &&
                controller
                    .applicationController.state.publish.value.pics.isEmpty &&
                controller
                    .applicationController.state.publish.value.video.isEmpty
            ? const SizedBox()
            : getButton(
                background: Colors.transparent,
                child: SizedBox(
                  child: Center(
                    child: getButtonSheet(
                      child: getSpan('发布'),
                    ),
                  ),
                ),
              )),
        SizedBox(width: 16.w),
      ],
    );

    var reply = Obx(
      () => getButtonList(
        icon: SvgPicture.asset(
          'assets/svg/set_shield_list.svg',
          height: 20.h,
        ),
        title: controller.applicationController.state.publish.value
                    .replyPermissionType ==
                1
            ? '任何人都可以回复'
            : controller.applicationController.state.publish.value
                        .replyPermissionType ==
                    2
                ? '仅您订阅的人可以回复'
                : controller.applicationController.state.publish.value
                            .replyPermissionType ==
                        3
                    ? '仅您提及的人可以回复'
                    : '仅订阅您的人可以回复',
      ),
    );
    var media = Obx(
      () => getButton(
        width: Get.width,
        padding: EdgeInsets.all(16.w),
        background: AppColors.secondBacground,
        borderRadius: BorderRadius.zero,
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.w)),
                color: AppColors.line,
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.secondIcon,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSpanTitle(controller.applicationController.state.publish
                            .value.pics.isEmpty &&
                        controller.applicationController.state.publish.value
                            .video.isEmpty
                    ? '媒体资源：无'
                    : controller.applicationController.state.publish.value.pics
                            .isNotEmpty
                        ? '图片：X张'
                        : '视频：00:00:00'),
                SizedBox(height: 6.h),
                getSpanSecond('收费方式：免费')
              ],
            ),
            const Spacer(),
            getRightIcon(),
          ],
        ),
      ),
    );

    var body = Column(
      children: [
        Expanded(child: input),
        Column(
          children: [
            SizedBox(height: 20.h),
            media,
            SizedBox(height: 1.h),
            reply,
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}