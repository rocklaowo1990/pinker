import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/fogot/type/library.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotTypeView extends GetView<ForgotTypeController> {
  const ForgotTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget title = getSpan(
      '您想要通过何种方式重置密码',
      fontSize: 26,
      textAlign: TextAlign.center,
    );

    /// 副标题
    Widget titleSecond = getSpan(
      '可以使用于您的账号关联的信息',
      color: AppColors.secondText,
    );

    /// 手机验证列表
    Widget listPhone = getButtonList(
        icon: Obx(() => Icon(
              Icons.check_circle,
              size: 10.sp,
              color: controller.forgotController.state.verifyType == 1
                  ? AppColors.mainColor
                  : AppColors.thirdIcon,
            )),
        iconRight: const SizedBox(),
        onPressed: controller.handlePhoneType,
        title:
            '向尾号 ${getLastTwo(controller.forgotController.userInfo.phone!)} 的电话号码发送验证码');

    /// 邮箱验证列表
    Widget listEmail = getButtonList(
        icon: Obx(() => Icon(
              Icons.check_circle,
              size: 10.sp,
              color: controller.forgotController.state.verifyType == 2
                  ? AppColors.mainColor
                  : AppColors.thirdIcon,
            )),
        iconRight: const SizedBox(),
        onPressed: controller.handleEmailType,
        title:
            '向尾号 ${getEmailHide(controller.forgotController.userInfo.email!)} 的电子邮箱发送验证码');

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: getButton(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child: getSpan(Lang.next.tr),
        onPressed: controller.handleNext,
        background: AppColors.mainColor,
      ),
    );

    /// body布局
    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  title,
                  SizedBox(height: 8.h),
                  titleSecond,
                ],
              ),
            ),
            if (controller.forgotController.userInfo.phone != '') listPhone,
            if (controller.forgotController.userInfo.email != '')
              SizedBox(height: 4.w),
            if (controller.forgotController.userInfo.email != '') listEmail,
          ],
        ),
        bottom,
      ],
    );
    return Obx(() => controller.forgotController.state.pageIndex != 2
        ? Stack(
            // 遮罩层
            children: [body, Container(color: Colors.black12)],
          )
        : body);
  }
}
