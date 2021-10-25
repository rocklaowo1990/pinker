import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        getSpan('挑选一个个人的资料图片', size: 16.sp),
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
            child: Icon(
              Icons.account_circle,
              size: 80.w,
              color: AppColors.mainBacground,
            ),
          ),
        ),
        getButton(
          onPressed: controller.handleGetImage,
          background: Colors.transparent,
          overlayColor: Colors.transparent,
          child: Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.w, color: AppColors.mainColor),
              color: AppColors.secondBacground,
            ),
            child: Center(
              child: Icon(
                Icons.add_circle,
                size: 16.w,
                color: AppColors.mainColor,
              ),
            ),
          ),
        ),
      ],
    );

    Widget bottom = Column(
      children: [
        getButton(
          child: getSpan(Lang.next),
          width: double.infinity,
        ),
        SizedBox(height: 4.h),
        getButton(
          child: getSpan('暂时跳过', color: AppColors.mainColor),
          width: double.infinity,
          background: Colors.transparent,
        ),
      ],
    );

    /// body布局
    Widget body = Padding(
      padding: EdgeInsets.only(
        top: 24.h,
        right: 20.w,
        bottom: 30.h,
        left: 20.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          top,
          middle,
          bottom,
        ],
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
