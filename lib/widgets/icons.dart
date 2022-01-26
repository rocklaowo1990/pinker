import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getCheckIcon({
  required bool isChooise,
}) {
  /// 单选按钮默认状态
  return isChooise
      ? Icon(
          Icons.check_circle,
          size: 16.sp,
          color: AppColors.mainColor,
        )
      : Container(
          width: 16.sp,
          height: 16.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.w,
              color: AppColors.thirdIcon,
            ),
          ),
        );
}

/// 返回按钮
Widget getBackIcon({void Function()? onPressed}) {
  return _getIcon(url: 'assets/svg/icon_back.svg');
}

/// 设置按钮
Widget getSettingIcon({void Function()? onPressed}) {
  return _getIcon(url: 'assets/svg/icon_setting.svg', height: 20.h);
}

/// appBar 左侧的返回按钮
Widget _getIcon({
  required String url,
  double? height,
  double? width,
}) {
  return SvgPicture.asset(
    url,
    height: height ?? 16.w,
    width: width ?? 16.w,
  );
}

Widget getLoadingIcon() {
  return Center(
    child: Column(
      children: [
        SizedBox(height: 40.h),
        SizedBox(
            width: 16.w,
            height: 16.w,
            child: CircularProgressIndicator(
                backgroundColor: AppColors.mainIcon,
                color: AppColors.mainColor,
                strokeWidth: 1.5.w)),
        SizedBox(height: 20.h),
        getSpanSecond('加载中...'),
      ],
    ),
  );
}

Widget getNoDataIcon() {
  return Center(
    child: Column(
      children: [
        SizedBox(height: 40.h),
        SvgPicture.asset('assets/svg/error_4.svg', width: 80.w),
        SizedBox(height: 20.h),
        getSpanSecond('暂无数据'),
      ],
    ),
  );
}

Widget getLogoIcon() {
  return Icon(
    IconFont.logo,
    size: 40.w,
    color: AppColors.mainColor,
  );
}
