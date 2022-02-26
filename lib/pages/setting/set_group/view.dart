import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/setting/set_group/library.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetGroupView extends GetView<SetGroupController> {
  const SetGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar 右侧的设置按钮
    Widget settingBox = getButton(
      child: const Icon(Icons.add, size: 24),
      onPressed: controller.handleAddGroup,
      background: Colors.transparent,
      width: 60,
      height: 60,
    );

    /// appBar
    AppBar appBar = getAppBar(
      getSpanTitle('订阅组列表'),
      backgroundColor: AppColors.secondBacground,
      lineColor: AppColors.line,
      actions: [
        Obx(() => controller.state.groupList.length >= 3
            ? const SizedBox()
            : settingBox)
      ],
    );

    Widget groupList({
      required String groupName,
      required String groupPic,
      required int createDate,
      required double amount,
    }) {
      return Container(
        width: double.infinity,
        height: 140,
        padding: const EdgeInsets.only(left: 40, right: 40),
        decoration: const BoxDecoration(
          gradient: AppColors.groupBackground,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    getSpanTitle(groupName),
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
                      height: 13,
                    ),
                    const SizedBox(width: 8),
                    getSpan('$amount'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    getSpan('创建时间：'),
                    getSpan(getDate(createDate)),
                  ],
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    width: 77,
                    height: 77,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondBacground,
                    ),
                    child: getNetworkImageBox(groupPic, shape: BoxShape.circle),
                  ),
                ),
                SvgPicture.asset(
                  'assets/svg/icon_group_avatar_bac.svg',
                ),
              ],
            ),
          ],
        ),
      );
    }

    /// body
    Widget body = Obx(() => controller.state.isLoading
        ? getLoadingIcon()
        : controller.state.groupList.isEmpty
            ? getNoDataIcon()
            : ListView(
                children: controller.state.groupList
                    .map((item) => Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: getButton(
                          child: groupList(
                            groupName: item.groupName,
                            groupPic: item.groupPic,
                            createDate: item.createDate,
                            amount: item.amount,
                          ),
                          onPressed: () {
                            controller.handleEditGroup(item);
                          },
                        )))
                    .toList()));

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
