import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/avatar/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class AvatarView extends GetView<AvatarController> {
  const AvatarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题部分组合
    Widget top = Column(
      children: [
        getSpan('挑选一个个人的资料图片', fontSize: 26),
        SizedBox(height: 8.h),
        getSpan(
          '有最爱的自拍？赶紧上传吧',
          color: AppColors.secondText,
          textAlign: TextAlign.center,
        ),
      ],
    );

    /// 中间部分
    Widget middle = Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondBacground,
          ),
          child: Center(
            child: Obx(
              () => controller.state.image == 0
                  ? SvgPicture.asset(
                      'assets/svg/avatar_default.svg',
                      width: 80.w,
                    )
                  : CircleAvatar(
                      radius: 80.w,
                      backgroundImage: FileImage(controller.avatarFile),
                    ),
            ),
          ),
        ),
        getButton(
          onPressed: controller.handleGetImage,
          background: Colors.transparent,
          overlayColor: Colors.transparent,
          child: Container(
            width: 24.w,
            height: 24.w,
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

    Widget bottom = Column(
      children: [
        Obx(
          () => getButton(
            padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
            child: getSpan(Lang.next.tr),
            width: double.infinity,
            background: controller.state.image <= 0
                ? AppColors.buttonDisable
                : AppColors.mainColor,
            onPressed:
                controller.state.image <= 0 ? null : controller.handleNext,
          ),
        ),
        SizedBox(height: 4.h),
        getButton(
          padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
          child: getSpan('暂时跳过', color: AppColors.mainColor),
          width: double.infinity,
          background: Colors.transparent,
          onPressed: controller.handleNotNow,
        ),
      ],
    );

    /// body布局
    Widget body = SingleChildScrollView(
      child: SizedBox(
        height: 406.h - 40.h,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              top,
              middle,
              bottom,
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != -2
            ? Stack(
                // 遮罩层
                children: [
                  body,
                  Container(
                    color: Colors.black12,
                  )
                ],
              )
            : body,
      ),
    );
  }
}
