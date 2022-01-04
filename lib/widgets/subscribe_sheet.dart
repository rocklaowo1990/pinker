import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/api/content.dart';

import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/subscribe_info.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 订阅弹窗
///
/// 先获取这个人的订阅信息
///
/// 然后走订阅付费流程
Future<void> getSubscribeBox({
  required Rx<UserInfoEntities> userInfo,
  required Rx<ContentListEntities> contentList,
  required int index,
  required VoidCallback reSault,
}) async {
  int groupId = 0;
  double groupPrice = 0;
  final amount = 0.0.obs;
  final choose = 0.obs;
  final isLoading = true.obs;
  SubscribeInfoEntities subscribeInfo =
      SubscribeInfoEntities.fromJson(SubscribeInfoEntities.child);

  ResponseEntity responseEntity = await UserApi.oneSubscribeInfo(
    userId: contentList.value.list[index].author.userId,
  );

  print(contentList.value.list[index].works.replyPermission.groupId);

  if (responseEntity.code == 200) {
    subscribeInfo = SubscribeInfoEntities.fromJson(responseEntity.data);
    for (int i = 0; i < subscribeInfo.groups.length; i++) {
      print(contentList.value.list[index].works.replyPermission.groupId);
      print(subscribeInfo.groups[i].groupId);

      if (contentList.value.list[index].works.replyPermission.groupId ==
          subscribeInfo.groups[i].groupId) {
        groupPrice = subscribeInfo.groups[i].amount;
      }
    }

    for (int i = 0; i < subscribeInfo.groups.length; i++) {
      if (subscribeInfo.groups[i].amount < groupPrice) {
        subscribeInfo.groups.remove(subscribeInfo.groups[i]);
      }
    }

    groupId = subscribeInfo.groups[0].groupId;
    amount.value = subscribeInfo.groups[0].amount;

    isLoading.value = false;
  } else {
    getSnackTop(responseEntity.msg);
  }

  /// 头像
  Widget avatarBox(
    String url, {
    double? width,
    double? height,
  }) {
    return Container(
      width: width ?? 26.w,
      height: height ?? 26.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.thirdIcon,
      ),
      child: Center(
        child: getImageBox(
          url,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  /// 文字部分
  Widget span =
      getSpan('请选择 ${contentList.value.list[index].author.userName} 的订阅方式');

  List groupList = [];
  for (int i = 0; i < subscribeInfo.groups.length; i++) {
    if (subscribeInfo.groups[i].amount >=
        contentList.value.list[index].works.payPermission.price!) {
      groupList.add(subscribeInfo.groups[i]);
    }
  }

  /// 分组
  Widget typeBox = SizedBox(
    height: double.infinity,
    child: Scrollbar(
      child: ListView.builder(
        itemCount: groupList.length,
        itemBuilder: (context, itemIndex) {
          return Obx(() => Column(
                children: [
                  getButton(
                    padding: EdgeInsets.all(4.w),
                    background: AppColors.mainBacground,
                    onPressed: itemIndex == choose.value
                        ? null
                        : () {
                            amount.value = groupList[itemIndex].amount;
                            groupId = groupList[itemIndex].groupId;
                            choose.value = itemIndex;
                          },
                    side: itemIndex == choose.value
                        ? const BorderSide(color: AppColors.mainColor)
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            avatarBox(
                              subscribeInfo.groups[itemIndex].groupPic,
                              width: 24.h,
                              height: 24.h,
                            ),
                            SizedBox(width: 8.w),
                            getSpan(subscribeInfo.groups[itemIndex].groupName),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/icon_diamond.svg',
                              height: 15,
                            ),
                            SizedBox(width: 4.w),
                            getSpan(
                                '${subscribeInfo.groups[itemIndex].amount}'),
                            SizedBox(width: 8.w),
                            Icon(Icons.check_circle,
                                size: 10.w,
                                color: itemIndex == choose.value
                                    ? AppColors.mainColor
                                    : AppColors.thirdIcon),
                            SizedBox(width: 8.w),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  )
                ],
              ));
        },
      ),
    ),
  );
  Widget button = getButton(
      width: double.infinity,
      height: 25.h,
      child: Obx(() => getSpan('确认支付 ${amount.value} 钻石')),
      onPressed: () async {
        getDialog(
          child: DialogChild.alert(
            title: '是否确认支付',
            content: '${amount.value} 钻石',
            onPressedRight: () async {
              ResponseEntity _responseEntity = await UserApi.subscribeGroup(
                userId: contentList.value.list[index].author.userId,
                groupId: groupId,
              );

              if (_responseEntity.code == 200) {
                getDialog();
                getUserInfo(userInfo);

                for (int i = 0; i < contentList.value.list.length; i++) {
                  if (contentList.value.list[i].author.userId ==
                      contentList.value.list[index].author.userId) {
                    ResponseEntity _userinfo = await ContentApi.contentDetail(
                        wid: contentList.value.list[i].wid);
                    if (_userinfo.code == 200) {
                      contentList.update((val) {
                        val!.list[i] =
                            ContentDetailElement.fromJson(_userinfo.data);
                      });
                    } else {
                      getSnackTop(_userinfo.msg);
                    }
                  }
                }
                reSault();

                Get.back();
                Get.back();
              } else {
                Get.back();
                getSnackTop(_responseEntity.msg);
              }
            },
            leftText: '取消',
            onPressedLeft: () {
              Get.back();
            },
          ),
          autoBack: true,
        );
      });
  Widget body = Obx(
    () => Container(
      height: 203.h,
      color: AppColors.secondBacground,
      child: isLoading.value
          ? Center(
              child: Column(children: [
              SizedBox(height: 40.h),
              SizedBox(
                  width: 9.w,
                  height: 9.w,
                  child: CircularProgressIndicator(
                      backgroundColor: AppColors.mainIcon,
                      color: AppColors.mainColor,
                      strokeWidth: 1.w)),
              SizedBox(height: 6.h),
              getSpan('加载中...', color: AppColors.secondText),
            ]))
          : Padding(
              padding: EdgeInsets.all(9.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // avatarBox(contentList.value.list[index].author.avatar),
                  SizedBox(height: 9.h),
                  span,
                  SizedBox(height: 9.h),
                  Expanded(child: typeBox),
                  SizedBox(height: 9.h),
                  button,
                  SizedBox(height: 9.h),
                  getSpan(
                    '当前钻石余额：${subscribeInfo.balance}',
                    color: AppColors.secondText,
                  )
                ],
              ),
            ),
    ),
  );

  /// 返回
  Get.bottomSheet(
    SingleChildScrollView(
      child: body,
    ),
    // backgroundColor: AppColors.dateBox,
    // isDismissible: false, // 用户点击空白区域是否可以返回
  );
}
