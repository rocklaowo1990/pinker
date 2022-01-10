import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/subscribe_info.dart';
import 'package:pinker/utils/utils.dart';

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
  String groupPrice = '0.00';
  final amount = '0.00'.obs;
  final choose = 0.obs;
  final isLoading = true.obs;
  SubscribeInfoEntities subscribeInfo =
      SubscribeInfoEntities.fromJson(SubscribeInfoEntities.child);

  ResponseEntity responseEntity = await UserApi.oneSubscribeInfo(
    userId: contentList.value.list[index].author.userId,
  );

  if (responseEntity.code == 200) {
    subscribeInfo = SubscribeInfoEntities.fromJson(responseEntity.data);
    for (int i = 0; i < subscribeInfo.groups.length; i++) {
      if (contentList.value.list[index].works.payPermission.groupId ==
          subscribeInfo.groups[i].groupId) {
        groupPrice = subscribeInfo.groups[i].amount;
      }
    }

    for (int i = 0; i < subscribeInfo.groups.length; i++) {
      if (double.parse(subscribeInfo.groups[i].amount) <
          double.parse(groupPrice)) {
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
  Widget avatarBox = Container(
    width: 30.w,
    height: 30.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.thirdIcon,
      border: Border.all(
        color: AppColors.secondBacground,
        width: 2,
      ),
    ),
    child: Center(
      child: contentList.value.list[index].author.avatar.isEmpty ||
              isInclude(contentList.value.list[index].author.avatar,
                  'user_default_head.png')
          ? SvgPicture.asset(
              'assets/svg/avatar_default.svg',
              width: 32.w,
            )
          : getImageBox(contentList.value.list[index].author.avatar,
              shape: BoxShape.circle),
    ),
  );

  /// 文字部分
  Widget span =
      getSpan('请选择 ${contentList.value.list[index].author.userName} 的订阅方式');

  Widget payBody = Padding(
    padding: EdgeInsets.fromLTRB(0, 4.h, 0, 4.h),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (int itemIndex = 0;
            itemIndex < subscribeInfo.groups.length;
            itemIndex++)
          Obx(() => getContentPayChooiseBox(
              title:
                  subscribeInfo.subGroupList == null ? '订阅 TA 的' : '升级到 TA 的',
              avatar: subscribeInfo.groups[itemIndex].groupPic,
              groupName: subscribeInfo.groups[itemIndex].groupName,
              timeLength: '(30天)',
              amount: subscribeInfo.groups[itemIndex].amount,
              isChooise: itemIndex == choose.value ? true : false,
              onPressed: () {
                amount.value = subscribeInfo.groups[itemIndex].amount;
                groupId = subscribeInfo.groups[itemIndex].groupId;
                choose.value = itemIndex;
              },
              margin: subscribeInfo.groups.length > 1 &&
                      itemIndex != subscribeInfo.groups.length - 1
                  ? 8.w
                  : null))
      ]),
    ),
  );

  Widget button = getButton(
      width: double.infinity,
      height: 25.h,
      child: Obx(() => getSpan('确认支付 ${amount.value} 钻石')),
      onPressed: () async {
        Get.back();
        await futureMill(200);
        getDialog(
          child: DialogChild.alert(
            title: '是否确认支付',
            contentWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/icon_diamond.svg',
                  height: 15,
                ),
                SizedBox(width: 3.w),
                getSpan('${amount.value} 钻石'),
              ],
            ),
            onPressedRight: () async {
              Get.back();
              getDialog();
              ResponseEntity _responseEntity = await UserApi.subscribeGroup(
                userId: contentList.value.list[index].author.userId,
                groupId: groupId,
              );

              if (_responseEntity.code == 200) {
                await getUserInfo();
                await futureMill(500);
                Get.back();

                reSault();

                await onRefreshContentList(
                    userId: contentList.value.list[index].author.userId);

                getSnackTop(getDate(_responseEntity.data['endDate']).toString(),
                    isError: false);
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
      Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.secondBacground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.w),
                      topRight: Radius.circular(8.w),
                    )),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    children: [
                      SizedBox(height: 9.h),
                      span,
                      SizedBox(height: 9.h),
                      payBody,
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
            ],
          ),
          Center(child: avatarBox),
        ],
      )
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

Widget getContentPayChooiseBox({
  required String title,
  String? avatar,
  required String groupName,
  required String timeLength,
  required String amount,
  VoidCallback? onPressed,
  double? margin,
  required bool isChooise,
}) {
  /// 头像
  Widget avatarBox = avatar != null
      ? Container(
          width: 26.w,
          height: 26.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.thirdIcon,
          ),
          child: Center(
            child: getImageBox(
              avatar,
              shape: BoxShape.circle,
            ),
          ),
        )
      : SvgPicture.asset(
          'assets/svg/icon_buy_only.svg',
          width: 26.w,
          height: 26.w,
        );

  Widget pay = getButton(
    onPressed: isChooise == true ? null : onPressed,
    borderSide: isChooise == true
        ? const BorderSide(color: AppColors.mainColor, width: 1)
        : null,
    borderRadius: BorderRadius.all(Radius.circular(4.w)),
    background:
        isChooise == true ? AppColors.mainColor20 : AppColors.mainBacground,
    width: 70.w,
    child: Column(
      children: [
        SizedBox(height: 12.h),
        getSpan(title),
        SizedBox(height: 6.h),
        avatarBox,
        SizedBox(height: 6.h),
        getSpan(groupName),
        getSpan(timeLength, color: AppColors.secondText),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/icon_diamond.svg',
              height: 15,
            ),
            SizedBox(width: 3.w),
            getSpan(amount),
          ],
        ),
        SizedBox(height: 12.h),
      ],
    ),
  );

  Widget payChooise = Stack(
    children: [
      pay,
      Positioned(
        child: Container(
          height: 20.w,
          width: 20.w,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(4.w)),
              image: const DecorationImage(
                  image: AssetImage('assets/images/icon_chooise.png'))),
        ),
        bottom: 0,
        right: 0,
      )
    ],
  );

  Widget payBox = Row(
    children: [
      !isChooise ? pay : payChooise,
      if (margin != null) SizedBox(width: margin),
    ],
  );

  return payBox;
}
