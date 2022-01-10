import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 推文右侧最多按钮
///
/// 这里对应的有自己的推文和别人的推文
Future<void> getContentMoreSheet({
  required Rx<ContentListEntities> contentList,
  required int index,
}) async {
  /// 屏蔽用户
  Widget block = getButtonList(
    icon: SvgPicture.asset('assets/svg/set_password.svg'),
    title: '屏蔽 @${contentList.value.list[index].author.nickName}',
    secondTitle: getSpan(
      '屏蔽',
      color: AppColors.secondIcon,
    ),
    onPressed: () {
      Get.back();
      getDialog(
        child: DialogChild.alert(
          title: '警告',
          content: '屏蔽某人后，你们将无法互相关注和私信对方并且您将看不到来自对方的通知和作品',
          onPressedRight: () async {
            Get.back();
            getDialog();

            ResponseEntity responseEntity = await UserApi.block(
              userId: contentList.value.list[index].author.userId,
              isBlock: 1,
            );

            if (responseEntity.code == 200) {
              await onHideContentList(
                  userId: contentList.value.list[index].author.userId);
              await futureMill(500);
              Get.back();
            } else {
              await futureMill(500);
              Get.back();
              getSnackTop(responseEntity.msg);
            }
          },
          leftText: '取消',
          onPressedLeft: () {
            Get.back();
          },
        ),
        autoBack: true,
      );
    },
  );

  /// 隐藏用户
  Widget hide = getButtonList(
    icon: SvgPicture.asset('assets/svg/set_password.svg'),
    title: '隐藏 @${contentList.value.list[index].author.nickName}',
    secondTitle: getSpan(
      '隐藏',
      color: AppColors.secondIcon,
    ),
    onPressed: () {
      Get.back();
      getDialog(
        child: DialogChild.alert(
          title: '提示',
          content: '当您隐藏某人后，您和他的聊天记录不会清除，您仍然可以收到来自该用户的通知',
          onPressedRight: () async {
            Get.back();
            getDialog();

            ResponseEntity responseEntity = await UserApi.hide(
              userId: contentList.value.list[index].author.userId,
              isHide: 1,
            );

            if (responseEntity.code == 200) {
              await onHideContentList(
                  userId: contentList.value.list[index].author.userId);
              Get.back();
            } else {
              await futureMill(500);
              Get.back();
              getSnackTop(responseEntity.msg);
            }
          },
          leftText: '取消',
          onPressedLeft: () {
            Get.back();
          },
        ),
        autoBack: true,
      );
    },
  );

  /// 举报推文
  Widget report = getButtonList(
    icon: SvgPicture.asset('assets/svg/set_password.svg'),
    title: '举报推文',
    secondTitle: getSpan(
      '举报',
      color: AppColors.secondIcon,
    ),
    onPressed: () {
      Get.back();
    },
  );

  Widget body = Column(
    children: [
      Expanded(
          child: getButton(
              width: double.infinity,
              background: Colors.transparent,
              overlayColor: Colors.transparent,
              height: double.infinity,
              child: const SizedBox(),
              onPressed: () {
                Get.back();
              })),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.secondBacground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.w),
              topRight: Radius.circular(8.w),
            )),
        child: Column(
          children: [
            SizedBox(height: 8.w),
            getSpan('请选择对他的操作', color: AppColors.secondText),
            SizedBox(height: 8.w),
            Container(height: 1, color: AppColors.line),
            block,
            Container(height: 1, color: AppColors.line),
            hide,
            Container(height: 1, color: AppColors.line),
            report,
          ],
        ),
      ),
    ],
  );

  /// 返回
  Get.bottomSheet(
    body,
    isScrollControlled: true,
    // backgroundColor: AppColors.dateBox,
    // isDismissible: false, // 用户点击空白区域是否可以返回
  );
}
