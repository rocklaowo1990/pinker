import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 订阅弹窗
///
/// 先获取这个人的订阅信息
///
/// 然后走订阅付费流程
Future<void> getSubscribeBox({
  required int userId,
  required String avatar,
  required String userName,
  required VoidCallback reSault,
}) async {
  int groupId = 0;
  final amount = '0.00'.obs;
  final choose = 0.obs;
  final isLoading = true.obs;
  SubscribeInfoEntities subscribeInfo =
      SubscribeInfoEntities.fromJson(SubscribeInfoEntities.child);

  ResponseEntity responseEntity = await UserApi.oneSubscribeInfo(
    userId: userId,
  );

  if (responseEntity.code == 200) {
    subscribeInfo = SubscribeInfoEntities.fromJson(responseEntity.data);

    if (subscribeInfo.groups.isNotEmpty) {
      for (int i = 0; i < subscribeInfo.groups.length; i++) {
        if (double.parse(subscribeInfo.groups[i].amount) < 0) {
          subscribeInfo.groups.remove(subscribeInfo.groups[i]);
        }
      }

      groupId = subscribeInfo.groups[0].groupId;
      amount.value = subscribeInfo.groups[0].amount;
    }

    isLoading.value = false;
  } else {
    getSnackTop(responseEntity.msg);
  }

  /// 头像
  Widget avatarBox = Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.thirdIcon,
      border: Border.all(
        color: AppColors.secondBacground,
        width: 2,
      ),
    ),
    child: Center(
      child: getNetworkImageBox(avatar, shape: BoxShape.circle),
    ),
  );

  /// 文字部分
  Widget span = getSpan('请选择 $userName 的订阅方式');

  Widget payBody = Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  ? 8
                  : null))
      ]),
    ),
  );

  Widget button = getButton(
      width: 250,
      height: 48,
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
                const SizedBox(width: 3),
                getSpan('${amount.value} 钻石'),
              ],
            ),
            onPressedRight: () async {
              Get.back();
              getDialog();
              ResponseEntity _responseEntity = await UserApi.subscribeGroup(
                userId: userId,
                groupId: groupId,
              );

              if (_responseEntity.code == 200) {
                await getUserInfo();
                await futureMill(500);
                Get.back();

                reSault();

                await onRefreshContentList(userId: userId);
                // await getContentListAll();

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
              width: Get.width,
              background: Colors.transparent,
              overlayColor: Colors.transparent,
              height: Get.height,
              child: const SizedBox(),
              onPressed: () {
                Get.back();
              })),
      Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 48),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.secondBacground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                    child: subscribeInfo.groups.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              span,
                              const SizedBox(height: 20),
                              payBody,
                              const SizedBox(height: 20),
                              button,
                              const SizedBox(height: 20),
                              getSpan(
                                '当前钻石余额：${subscribeInfo.balance}',
                                color: AppColors.secondText,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              getSpan(
                                '$userName 暂时还没有任何可以订阅的分组',
                                color: AppColors.secondText,
                              ),
                              const SizedBox(height: 11),
                            ],
                          ),
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
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.thirdIcon,
          ),
          child: Center(
            child: getNetworkImageBox(
              avatar,
              shape: BoxShape.circle,
            ),
          ),
        )
      : SvgPicture.asset(
          'assets/svg/icon_buy_only.svg',
          width: 40,
          height: 40,
        );

  Widget pay = getButton(
    onPressed: isChooise == true ? null : onPressed,
    borderSide: isChooise == true
        ? const BorderSide(color: AppColors.mainColor, width: 1)
        : null,
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    background:
        isChooise == true ? AppColors.mainColor20 : AppColors.mainBacground,
    width: 135,
    child: Column(
      children: [
        const SizedBox(height: 20),
        getSpanTitle(title),
        const SizedBox(height: 16),
        avatarBox,
        const SizedBox(height: 16),
        getSpan(groupName),
        const SizedBox(height: 4),
        getSpan(timeLength, color: AppColors.secondText),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/icon_diamond.svg',
              height: 15,
            ),
            const SizedBox(width: 3),
            getSpan(amount),
          ],
        ),
        const SizedBox(height: 12),
      ],
    ),
  );

  Widget payChooise = Stack(
    children: [
      pay,
      Positioned(
        child: Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
              image: DecorationImage(
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
