import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/fogot/info/library.dart';
import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

class ForgotInfoView extends StatelessWidget {
  const ForgotInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotInfoController>(
      init: ForgotInfoController(),
      builder: (controller) {
        /// 标题
        Widget title = getSpan('认证您的个人信息', fontSize: 26);

        /// 头像
        Widget avatar = Container(
          width: 40.w,
          height: 40.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondBacground,
          ),
          child: Center(
            child: controller.forgotController.userInfo.avatar == '' ||
                    controller.forgotController.userInfo.avatar == null
                ? SvgPicture.asset(
                    'assets/svg/avatar_default.svg',
                    width: 80.w,
                  )
                : CircleAvatar(
                    radius: 80.w,
                    backgroundImage: NetworkImage(
                        controller.forgotController.userInfo.avatar!),
                  ),
          ),
        );

        /// 昵称
        Widget nickName = getSpan(
          controller.forgotController.userInfo.nickName,
          fontSize: 17,
        );

        /// 用户名
        Widget userName = getSpan(
          '@${controller.forgotController.userInfo.userName}',
          color: AppColors.secondText,
        );

        /// 账号输入框
        Widget userCount = getInput(
          type: '手机号码或邮箱地址',
          controller: controller.textController,
          autofocus: true,
          focusNode: controller.focusNode,
          textInputAction: TextInputAction.next,
        );

        /// 底部
        Widget bottom = getBottomBox(
          rightWidget: Obx(
            () => getButton(
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              child: getSpan(Lang.next.tr),
              onPressed:
                  controller.state.isDissable ? null : controller.handleNext,
              background: controller.state.isDissable
                  ? AppColors.buttonDisable
                  : AppColors.mainColor,
            ),
          ),
        );

        /// body布局
        Widget body = Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      title,
                      SizedBox(height: 10.h),
                      avatar,
                      SizedBox(height: 10.h),
                      nickName,
                      SizedBox(height: 1.h),
                      userName,
                      SizedBox(height: 10.h),
                      userCount,
                    ],
                  ),
                ),
              ),
            ),
            bottom,
          ],
        );
        return Obx(() => controller.forgotController.state.pageIndex != 1
            ? Stack(
                // 遮罩层
                children: [body, Container(color: Colors.black12)],
              )
            : body);
      },
    );
  }
}
