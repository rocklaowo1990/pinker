import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/publish/reply/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ReplyView extends GetView<ReplyController> {
  const ReplyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = getAppBar(
      getSpan('设置回复权限'),
      actions: [
        Obx(
          () => controller.state.replyGroupId !=
                      controller
                          .publishController.state.publish.value.replyGroupId ||
                  controller.state.replyPermissionType !=
                      controller.publishController.state.publish.value
                          .replyPermissionType
              ? getButton(
                  background: Colors.transparent,
                  child: SizedBox(
                    child: Center(
                      child: getButtonSheet(
                        child: getSpan(Lang.sure.tr),
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.publishController.state.publish.value
                            .replyPermissionType =
                        controller.state.replyPermissionType;
                    controller.publishController.state.publish.value
                        .replyGroupId = controller.state.replyGroupId;
                    controller.publishController.state.publish.value.groupName =
                        controller.groupName;
                    controller.publishController.state.publish.update((val) {});

                    Get.back();
                  })
              : const SizedBox(),
        ),
        const SizedBox(width: 16),
      ],
    );
    var column = Obx(
      () => Column(
        children: ListTile.divideTiles(
          tiles: [
            ListTile(
              leading: Obx(
                () => getCheckIcon(
                  isChooise:
                      controller.state.replyPermissionType == 1 ? true : false,
                ),
              ),
              title: getSpan('任何人都可以回复'),
              onTap: () {
                controller.state.replyPermissionType = 1;
              },
            ),
            ListTile(
              leading: Obx(
                () => getCheckIcon(
                  isChooise:
                      controller.state.replyPermissionType == 2 ? true : false,
                ),
              ),
              title: getSpan('仅您订阅的人可以回复'),
              onTap: () {
                controller.state.replyPermissionType = 2;
              },
            ),
            ListTile(
              leading: Obx(
                () => getCheckIcon(
                  isChooise:
                      controller.state.replyPermissionType == 3 ? true : false,
                ),
              ),
              title: getSpan('仅您提及的人可以回复'),
              onTap: () {
                controller.state.replyPermissionType = 3;
              },
            ),
            ListTile(
              leading: Obx(
                () => getCheckIcon(
                  isChooise: controller.state.replyPermissionType == 4 &&
                          controller.state.replyGroupId == 0
                      ? true
                      : false,
                ),
              ),
              title: getSpan('仅订阅您的人可以回复（所有订阅组都可以回复）'),
              onTap: () {
                controller.state.replyPermissionType = 4;
                controller.state.replyGroupId = 0;
              },
            ),
            for (int i = 0; i < controller.state.groupList.length; i++)
              Obx(
                () => ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: getCheckIcon(
                      isChooise: controller.state.replyPermissionType == 4 &&
                              controller.state.replyGroupId ==
                                  controller.state.groupList[i].groupId
                          ? true
                          : false,
                    ),
                  ),
                  title: getSpan(
                      '仅订阅组“${controller.state.groupList[i].groupName}”可以回复'),
                  onTap: () {
                    controller.state.replyPermissionType = 4;
                    controller.state.replyGroupId =
                        controller.state.groupList[i].groupId;
                    controller.groupName =
                        controller.state.groupList[i].groupName;
                  },
                ),
              ),
          ],
          color: AppColors.line,
        ).toList(),
      ),
    );
    var body = ListView(
      children: [
        column,
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: body,
      backgroundColor: AppColors.mainBacground,
    );
  }
}
