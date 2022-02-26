import 'package:flutter/material.dart';

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
      style: const TextStyle(color: AppColors.mainText, fontSize: 14),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        fillColor: AppColors.inputFiled,
        filled: true,
        hintText: '有什么新鲜事?',
        hintStyle: TextStyle(color: AppColors.secondText),
        counterStyle: TextStyle(color: AppColors.mainText),
      ),
      maxLength: 200,
    );

    var appBar = getAppBar(
      getSpanTitle('发推'),
      backgroundColor: AppColors.secondBacground,
      actions: [
        Obx(() => controller.state.publish.value.content.isEmpty &&
                controller.state.publish.value.pics.isEmpty &&
                controller.state.publish.value.video.isEmpty
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
        const SizedBox(width: 16),
      ],
    );

    var reply = Obx(
      () => getButtonList(
        onPressed: controller.handleReply,
        icon: SvgPicture.asset(
          'assets/svg/set_shield_list.svg',
          height: 20,
        ),
        title: controller.state.publish.value.replyPermissionType == 1
            ? '任何人都可以回复'
            : controller.state.publish.value.replyPermissionType == 2
                ? '仅您订阅的人可以回复'
                : controller.state.publish.value.replyPermissionType == 3
                    ? '仅您提及的人可以回复'
                    : controller.state.publish.value.replyPermissionType == 4 &&
                            controller.state.publish.value.replyGroupId == 0
                        ? '仅订阅您的人可以回复'
                        : '仅订阅组“${controller.state.publish.value.groupName}”可以回复',
      ),
    );
    var media = Obx(
      () => getButton(
        width: Get.width,
        padding: const EdgeInsets.all(16),
        background: AppColors.secondBacground,
        borderRadius: BorderRadius.zero,
        onPressed: () {},
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: AppColors.line,
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.secondIcon,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSpanTitle(controller.state.publish.value.pics.isEmpty &&
                        controller.state.publish.value.video.isEmpty
                    ? '媒体资源：无'
                    : controller.state.publish.value.pics.isNotEmpty
                        ? '图片：X张'
                        : '视频：00:00:00'),
                const SizedBox(height: 6),
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
            const SizedBox(height: 20),
            media,
            const SizedBox(height: 1),
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
