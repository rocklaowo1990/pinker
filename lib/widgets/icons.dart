import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getCheckIcon({
  required bool isChooise,
}) {
  /// 单选按钮默认状态
  return isChooise
      ? SvgPicture.asset('assets/svg/check_2.svg')
      : SvgPicture.asset(
          'assets/svg/check_1.svg',
          color: AppColors.thirdIcon,
        );
}

/// 返回按钮
Widget getBackIcon({void Function()? onPressed}) {
  return _getIcon(url: 'assets/svg/icon_back.svg');
}

/// 设置按钮
Widget getSettingIcon({void Function()? onPressed}) {
  return _getIcon(url: 'assets/svg/icon_setting.svg', height: 20);
}

/// appBar 左侧的返回按钮
Widget _getIcon({
  required String url,
  double? height,
  double? width,
}) {
  return SvgPicture.asset(
    url,
    height: height ?? 16,
    width: width ?? 16,
  );
}

Widget getLoadingIcon() {
  return Center(
    child: Column(
      children: [
        const SizedBox(height: 48),
        const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
                backgroundColor: AppColors.mainIcon,
                color: AppColors.mainColor,
                strokeWidth: 1.5)),
        const SizedBox(height: 20),
        getSpanSecond('加载中...'),
      ],
    ),
  );
}

Widget getNoDataIcon() {
  return Center(
    child: Column(
      children: [
        const SizedBox(height: 48),
        SvgPicture.asset('assets/svg/error_4.svg', width: 80),
        const SizedBox(height: 20),
        getSpanSecond('暂无数据'),
      ],
    ),
  );
}

Widget getLogoIcon() {
  return const Icon(
    IconFont.logo,
    size: 40,
    color: AppColors.mainColor,
  );
}

Widget getRightIcon({Color? color}) {
  return SvgPicture.asset(
    'assets/svg/icon_right.svg',
    width: 12,
    color: color,
  );
}
