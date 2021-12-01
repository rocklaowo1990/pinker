import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/setting/set_group/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetGroupView extends GetView<SetGroupController> {
  const SetGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar 右侧的设置按钮
    Widget settingBox = getButton(
      child: const Icon(Icons.add, size: 28),
      onPressed: controller.handleAddGroup,
      background: Colors.transparent,
      width: 30.w,
      height: 30.w,
    );

    /// appBar
    AppBar appBar = getAppBar(
      getSpan('设置订阅组', fontSize: 17),
      backgroundColor: AppColors.secondBacground,
      line: AppColors.line,
      actions: [settingBox],
    );

    Widget groupList({
      required String groupName,
      required String groupPic,
      required int timelen,
      required int amount,
    }) {
      return Container(
        width: double.infinity,
        height: 150,
        decoration: const BoxDecoration(
          gradient: AppColors.groupBackground,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 26),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  SvgPicture.asset(
                    'assets/svg/icon_group_avatar_bac.svg',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 21),
                    child: Container(
                      width: 77,
                      height: 77,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondBacground,
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                              serverApiUrl + serverPort + groupPic),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    getSpan(groupName,
                        fontSize: 17, fontWeight: FontWeight.w600),
                    const SizedBox(width: 12),
                    SvgPicture.asset(
                      'assets/svg/icon_edit.svg',
                      height: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    getSpan('价格：'),
                    SvgPicture.asset(
                      'assets/svg/icon_diamond.svg',
                      height: 16,
                    ),
                    const SizedBox(width: 8),
                    getSpan('$amount'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    getSpan('订阅时长：'),
                    getSpan('$timelen'),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    /// body
    Widget body = Obx(() => Scrollbar(
        child: controller.state.isLoading
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
            : controller.state.groupList.isEmpty
                ? Center(
                    child: Column(children: [
                    SizedBox(height: 40.h),
                    SvgPicture.asset('assets/svg/error_4.svg', width: 55.w),
                    SizedBox(height: 6.h),
                    getSpan('暂无数据', color: AppColors.secondText),
                  ]))
                : Column(children: [
                    Expanded(
                        child: ListView(
                            children: controller.state.groupList
                                .map((item) => Padding(
                                    padding: EdgeInsets.all(10.w),
                                    child: groupList(
                                      groupName: item['groupName'],
                                      groupPic: item['groupPic'],
                                      timelen: item['timelen'],
                                      amount: item['amount'],
                                    )))
                                .toList()))
                  ])));

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
