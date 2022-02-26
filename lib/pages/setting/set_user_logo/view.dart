import 'package:flutter/material.dart';

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
    AppBar appBar = getNoLineBar('水印设置');

    /// 底部
    Widget bottom = getBottomBox(
      rightWidget: Obx(
        () => getButtonSheet(
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
        height: 60,
        title: '水印开关',
        onPressed: controller.handleOnChangedNoValue,
        iconRight: Obx(() => Switch(
              value: controller.state.enable == 0 ? false : true,
              onChanged: controller.handleOnChanged,
            )));

    // 主体
    Widget _body = Column(
      children: [
        const SizedBox(height: 10),
        _switch,
        const SizedBox(height: 2),
        Container(
          child: Row(
            children: [
              getSpan('水印文字'),
              const SizedBox(width: 20),
              Expanded(child: _userLogoInput),
            ],
          ),
          color: AppColors.secondBacground,
          padding: const EdgeInsets.all(16),
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
                          const SizedBox(height: 30),
                          const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  backgroundColor: AppColors.mainIcon,
                                  color: AppColors.mainColor,
                                  strokeWidth: 1.5)),
                          const SizedBox(height: 20),
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
