import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/pages/fogot/widgets/library.dart';

import 'package:pinker/values/colors.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotView extends StatelessWidget {
  ForgotView({Key? key}) : super(key: key);
  final ForgotController controller = ForgotController();

  @override
  StatelessElement createElement() {
    controller.init();
    return StatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: Obx(
        () => getButton(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: getSpan(Lang.next.tr),
          onPressed: controller.state.isDissable ? null : controller.handleNext,
          background: controller.state.isDissable
              ? AppColors.buttonDisable
              : AppColors.mainColor,
        ),
      ),
    );

    /// appbar
    Widget appBar = getAppBar(
      getSpan('找回密码', fontSize: 17),
      backgroundColor: AppColors.mainBacground,
      elevation: 0,
      leading: getButton(
        child: const Icon(Icons.close, color: AppColors.mainIcon),
        background: AppColors.mainBacground,
        onPressed: controller.handleBack,
      ),
    );

    /// body布局
    Widget body = Column(
      children: [
        SizedBox(height: 25.h),
        appBar,
        Container(height: 1.h, color: AppColors.secondBacground),
        Expanded(
          child: Container(
            color: AppColors.mainBacground,
            padding: EdgeInsets.only(
              top: 20.h,
              right: 20.w,
              left: 20.w,
            ),
            child: forgotOne(controller),
          ),
        ),
        bottom,
      ],
    );

    return body;
  }
}
