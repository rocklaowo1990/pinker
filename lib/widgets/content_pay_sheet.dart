import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/api/content.dart';
import 'package:pinker/api/user.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/colors.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 订阅弹窗
///
/// 先获取这个人的订阅信息
///
/// 然后走订阅付费流程
Future<void> getContentPaySheet({
  required Rx<UserInfoEntities> userInfo,
  required Rx<ContentListEntities> contentList,
  required int index,
  required VoidCallback reSault,
}) async {
  final amount = '0.00'.obs;
  final choose = 0.obs;
  final isLoading = true.obs;
  var type = 1;
  var subscribeInfo =
      SubscribeInfoEntities.fromJson(SubscribeInfoEntities.child);

  ResponseEntity responseEntity = await UserApi.oneSubscribeInfo(
    userId: contentList.value.list[index].author.userId,
  );

  if (responseEntity.code == 200) {
    subscribeInfo = SubscribeInfoEntities.fromJson(responseEntity.data);
    subscribeInfo.groups.removeWhere((element) =>
        element.groupId !=
        contentList.value.list[index].works.payPermission.groupId);

    isLoading.value = false;
  } else {
    getSnackTop(responseEntity.msg);
  }

  /// 文字部分
  Widget span =
      getSpan('${contentList.value.list[index].author.userName} 设置了查看权限您需要');

  Widget _orAnd(int _type) {
    final _typeRx = 0.obs;
    _typeRx.value = _type;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => getContentPayChooiseBox(
            title: subscribeInfo.subGroupList == null ? '订阅 TA 的' : '升级到 TA 的',
            avatar: subscribeInfo.groups[0].groupPic,
            groupName: subscribeInfo.groups[0].groupName,
            timeLength: '(30天)',
            amount: subscribeInfo.groups[0].amount,
            isChooise: _typeRx.value == 1
                ? true
                : choose.value == 0
                    ? true
                    : false,
            onPressed: _typeRx.value == 1
                ? null
                : () {
                    amount.value = subscribeInfo.groups[0].amount;
                    choose.value = 0;
                    type = 1;
                  },
          ),
        ),
        SizedBox(width: 8.w),
        Obx(
          () => getContentPayChooiseBox(
            title: '单独购买',
            groupName: '这条推文',
            timeLength: '(永久)',
            amount: contentList.value.list[index].works.payPermission.price!
                .toStringAsFixed(2),
            isChooise: _typeRx.value == 1
                ? true
                : choose.value == 1
                    ? true
                    : false,
            onPressed: _typeRx.value == 1
                ? null
                : () {
                    amount.value = contentList
                        .value.list[index].works.payPermission.price!
                        .toStringAsFixed(2);
                    choose.value = 1;
                    type = 2;
                  },
          ),
        ),
      ],
    );
  }

  /// 分组
  Widget _payBody() {
    late Widget body;
    if (contentList.value.list[index].works.payPermission.type == 2) {
      amount.value = subscribeInfo.groups[0].amount;
      body = _orAnd(0);
    } else if (contentList.value.list[index].works.payPermission.type == 3) {
      if (subscribeInfo.groups.isEmpty) {
        amount.value = contentList.value.list[index].works.payPermission.price!
            .toStringAsFixed(2);
        body = getContentPayChooiseBox(
          title: '单独购买',
          groupName: '这条推文',
          timeLength: '(永久)',
          amount: contentList.value.list[index].works.payPermission.price!
              .toStringAsFixed(2),
          isChooise: true,
          onPressed: () {
            amount.value = contentList
                .value.list[index].works.payPermission.price!
                .toStringAsFixed(2);
            choose.value = 1;
          },
        );
      } else {
        var _amount = contentList.value.list[index].works.payPermission.price! +
            double.parse(subscribeInfo.groups[0].amount);
        amount.value = _amount.toStringAsFixed(2);
        body = _orAnd(1);
      }
    } else if (contentList.value.list[index].works.payPermission.type == 1) {
      amount.value = subscribeInfo.groups[0].amount;
      body = getContentPayChooiseBox(
        title: subscribeInfo.subGroupList == null ? '订阅 TA 的' : '升级到 TA 的',
        avatar: subscribeInfo.groups[0].groupPic,
        groupName: subscribeInfo.groups[0].groupName,
        timeLength: '(30天)',
        amount: subscribeInfo.groups[0].amount,
        isChooise: true,
      );
    } else {
      amount.value = contentList.value.list[index].works.payPermission.price!
          .toStringAsFixed(2);
      body = getContentPayChooiseBox(
        title: '单独购买',
        groupName: '这条推文',
        timeLength: '(永久)',
        amount: contentList.value.list[index].works.payPermission.price!
            .toStringAsFixed(2),
        isChooise: true,
        onPressed: () {
          amount.value = contentList
              .value.list[index].works.payPermission.price!
              .toStringAsFixed(2);
          choose.value = 1;
        },
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4.h, 0, 4.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: body,
      ),
    );
  }

  Widget button = getButton(
      width: 250.w,
      height: 48.h,
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
              ResponseEntity payment = await ContentApi.payment(
                wid: contentList.value.list[index].wid,
                type:
                    contentList.value.list[index].works.payPermission.type == 2
                        ? type
                        : null,
              );
              if (payment.code == 200) {
                await getUserInfo();

                Get.back();

                reSault();

                getSnackTop('购买成功', isError: false);

                if (type == 1 ||
                    contentList.value.list[index].works.payPermission.type ==
                        3 ||
                    contentList.value.list[index].works.payPermission.type ==
                        1) {
                  onRefreshContentList(
                      userId: contentList.value.list[index].author.userId);
                } else {
                  getContentOnly(
                    wid: contentList.value.list[index].wid,
                  );
                }
              } else {
                Get.back();
                getSnackTop(payment.msg);
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

  /// 头像
  Widget avatarBox = Container(
    width: 60.w,
    height: 60.w,
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
          : getNetworkImageBox(contentList.value.list[index].author.avatar,
              shape: BoxShape.circle),
    ),
  );
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
              SizedBox(height: 48.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.secondBacground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.w),
                      topRight: Radius.circular(16.w),
                    )),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 12.w, 24.w, 12.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        span,
                        SizedBox(height: 20.h),
                        _payBody(),
                        SizedBox(height: 20.h),
                        button,
                        SizedBox(height: 20.h),
                        getSpan(
                          '当前钻石余额：${subscribeInfo.balance}',
                          color: AppColors.secondText,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(child: avatarBox),
        ],
      ),
    ],
  );

  /// 返回
  Get.bottomSheet(
    body,
    isScrollControlled: true,
    // backgroundColor: AppColors.dateBox,
    isDismissible: false, // 用户点击空白区域是否可以返回
    ignoreSafeArea: false,
  );
}
