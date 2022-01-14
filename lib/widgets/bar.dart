import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// appBar
/// 普通的appBar
AppBar getAppBar(
  Widget title, {
  Widget? leading,
  List<Widget>? actions,
  Color? backgroundColor,
  Color? lineColor,
  Widget? bottom,
  double? bottomHeight,
}) {
  /// appBar 左侧的返回按钮
  Widget leadingDefault = getButton(
    child: SvgPicture.asset('assets/svg/icon_back.svg'),
    onPressed: () {
      Get.back();
    },
    background: Colors.transparent,
  );

  return AppBar(
    title: title,
    backgroundColor: backgroundColor ?? Colors.transparent,
    foregroundColor: AppColors.mainText,
    elevation: 0,
    bottom: bottom == null && lineColor == null
        ? null
        : PreferredSize(
            child: Column(
              children: [
                if (bottom != null)
                  SizedBox(
                    height: bottomHeight ?? 0,
                    child: bottom,
                  ),
                if (lineColor != null)
                  Container(
                    height: 0.8,
                    color: lineColor,
                  ),
              ],
            ),
            preferredSize: Size.fromHeight(bottom == null
                ? 0.8
                : lineColor == null
                    ? bottomHeight ?? 0
                    : bottomHeight == null
                        ? 0.8
                        : bottomHeight + 0.8),
          ),
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    leading: leading ?? leadingDefault,
    actions: actions,
  );
}

/// 没有返回键的appbar
/// 一般用在首页
AppBar getMainBar({required Widget left, required Widget right}) {
  return AppBar(
    // title: left,
    actions: [
      left,
      const Spacer(),
      right,
      // const SizedBox(),
    ],
    backgroundColor: AppColors.secondBacground,
    elevation: 0.5.w,
    shadowColor: AppColors.thirdIcon,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

/// appBar
/// 顶部带搜索的appbar
AppBar getSearchBar({
  required TextEditingController controller,
  required FocusNode focusNode,
}) {
  return AppBar(
    title: getInput(
      height: 40,
      contentPadding: EdgeInsets.only(left: 8.w),
      type: Lang.inputSearch.tr,
      controller: controller,
      focusNode: focusNode,
      prefixIcon: SizedBox(
        width: 10.h,
        height: 10.h,
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/icon_search_2.svg',
          ),
        ),
      ),
    ),
    backgroundColor: AppColors.mainBacground,
    elevation: 0.5.w,
    shadowColor: AppColors.thirdIcon,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}
