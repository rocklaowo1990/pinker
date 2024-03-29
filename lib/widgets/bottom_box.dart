import 'package:flutter/material.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:get/get.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 这是有键盘的时候，底部的那一条功能条
/// 常用的地方有注册页面的底部
/// 例如登陆页面的底部
Widget getBottomBox({
  Widget? leftWidget,
  Widget? rightWidget,
  String? rightText,
  void Function()? onPressed,
}) {
  /// 左侧初始化
  Widget left = const SizedBox();

  /// 右侧按钮初始化
  Widget right = getButton(
    child: getSpan(
      rightText ?? Lang.sure.tr,
      color: AppColors.mainText,
    ),
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
    onPressed: onPressed,
  );

  /// 底部 bottom 布局
  return Container(
    width: double.infinity,
    color: AppColors.secondBacground,
    child: SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        width: double.infinity,
        height: 48,
        color: AppColors.secondBacground,
        child: Row(
          children: [
            leftWidget ?? left,
            const Spacer(),
            rightWidget ?? right,
          ],
        ),
      ),
    ),
  );
}
