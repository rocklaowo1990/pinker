import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/set_group/group_info/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetGroupInfoView extends GetView<SetGroupInfoController> {
  const SetGroupInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan(controller.arguments == null ? '添加订阅组' : '订阅组信息', fontSize: 17),
      backgroundColor: AppColors.secondBacground,
      lineColor: AppColors.line,
    );

    /// 中间部分
    Widget middle = Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondBacground,
          ),
          child: Center(
              child: Obx(() => controller.state.image == 0
                  ? controller.arguments != null
                      ? getNetworkImageBox(controller.arguments!.groupPic,
                          shape: BoxShape.circle, width: 60.w, height: 60.w)
                      : SvgPicture.asset(
                          'assets/svg/avatar_default.svg',
                          width: 60.w,
                        )
                  : CircleAvatar(
                      radius: 60.w,
                      backgroundImage: FileImage(controller.avatarFile),
                    ))),
        ),
        getButton(
          onPressed: controller.handleGetImage,
          background: Colors.transparent,
          overlayColor: Colors.transparent,
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.w, color: AppColors.mainColor),
              color: AppColors.secondBacground,
            ),
            child: Center(
              child: Icon(
                Icons.photo_camera,
                size: 12.w,
                color: AppColors.mainColor,
              ),
            ),
          ),
        ),
      ],
    );

    /// 单选按钮默认状态
    Widget dialogDefault = Icon(
      Icons.check_circle,
      size: 10.w,
      color: AppColors.mainColor,
    );

    /// 订阅日期
    Widget day = getButton(
      overlayColor: Colors.transparent,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      background: Colors.transparent,
      child: Row(
        children: [
          dialogDefault,
          SizedBox(width: 4.w),
          Expanded(child: getSpan('30天'), flex: 1),
        ],
      ),
    );

    /// 头像
    Widget avatar = Container(
      child: Center(child: middle),
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: EdgeInsets.all(20.w),
    );

    // 资料编辑区
    Widget groupInfo = Container(
      child: Column(
        children: [
          getInput(
            type: '不超过七个字符',
            controller: controller.textEditingGroupName,
            focusNode: controller.focusGroupName,
            prefixIcon: Container(
              child: getSpan('分组名称', color: AppColors.mainColor),
              width: 100,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(height: 5.h),
          getInput(
            type: '输入钻石数量',
            controller: controller.textEditingPrice,
            focusNode: controller.focusPrice,
            prefixIcon: Container(
              child: Row(
                children: [
                  getSpan('订阅价格', color: AppColors.mainColor),
                  const SizedBox(width: 20),
                  SvgPicture.asset(
                    'assets/svg/icon_diamond.svg',
                    height: 15,
                  ),
                ],
              ),
              width: 130,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              const SizedBox(width: 20),
              getSpan('订阅时长', color: AppColors.mainColor),
              const SizedBox(width: 20),
              Expanded(
                child: day,
              ),
            ],
          ),
        ],
      ),
      width: double.infinity,
      color: AppColors.secondBacground,
      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.w),
    );

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: Obx(
        () => getButton(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: getSpan(Lang.sure.tr),
          onPressed: controller.state.isDissable ? null : controller.handleSure,
          background: controller.state.isDissable
              ? AppColors.buttonDisable
              : AppColors.mainColor,
        ),
      ),
    );

    /// body
    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView(
            children: [
              avatar,
              groupInfo,
            ],
          ),
        ),
        bottom,
      ],
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
