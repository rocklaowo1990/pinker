import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/setting/set_user_logo/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetUserLogoView extends GetView<SetUserLogoController> {
  const SetUserLogoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan('水印设置', fontSize: 17),
      backgroundColor: AppColors.secondBacground,
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

    /// 手机输入框
    Widget _userLogoInput = getInput(
      height: 30.h,
      type: '请输入水印文字',
      controller: controller.textController,
      focusNode: controller.focusNode,
    );

    // Widget _switch = Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Padding(
    //         padding: const EdgeInsets.only(left: 20),
    //         child: getSpan(
    //           '水印开关',
    //           color: AppColors.mainColor,
    //         )),
    //     Obx(() => Switch(
    //           value: controller.state.isSwitch,
    //           onChanged: controller.handleOnChanged,
    //         ))
    //   ],
    // );

    /// 用户名
    Widget _switch = getButtonList(
        height: 30.h,
        title: '水印开关',
        onPressed: controller.handleOnChangedNoValue,
        iconRight: Obx(() => Switch(
              value: controller.state.enable,
              onChanged: controller.handleOnChanged,
            )));

    // 主体
    Widget _body = Column(
      children: [
        SizedBox(height: 10.h),
        _switch,
        SizedBox(height: 0.5.h),
        Container(
          child: Row(
            children: [
              getSpan('水印文字'),
              SizedBox(width: 20.w),
              Expanded(child: _userLogoInput),
            ],
          ),
          color: AppColors.secondBacground,
          padding: EdgeInsets.all(9.w),
        ),
      ],
    );

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Obx(() => controller.state.isLoading
              ? Stack(children: [
                  _body,
                  Container(
                    color: AppColors.mainBacground50,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          SizedBox(
                              width: 9.w,
                              height: 9.w,
                              child: CircularProgressIndicator(
                                  backgroundColor: AppColors.mainIcon,
                                  color: AppColors.mainColor,
                                  strokeWidth: 1.w)),
                          SizedBox(height: 6.h),
                          getSpan('加载中...', color: AppColors.secondText),
                        ],
                      ),
                    ),
                  ),
                ])
              : _body),
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
