import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/code_list/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CodeListView extends GetView<CodeListController> {
  const CodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar
    AppBar appBar = getAppBar(
      getSpan(Lang.codeTitle.tr, fontSize: 17),
      backgroundColor: AppColors.secondBacground,
    );

    /// 搜索框
    Widget searchBox = getInput(
      type: Lang.inputSearch.tr,
      borderRadius: BorderRadius.zero,
      controller: controller.textController,
      focusNode: controller.focusNode,
      prefixIcon: SizedBox(
        width: 10.h,
        height: 10.h,
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/icon_search_2.svg',
          ),
        ),
      ),
    );

    /// body
    Widget body = Scrollbar(
      child: Column(
        children: [
          searchBox,
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => controller.state.isLoading
                    ? Center(
                        child: Column(children: [
                        SizedBox(height: 40.h),
                        SizedBox(
                            width: 9.w,
                            height: 9.w,
                            child: CircularProgressIndicator(
                                backgroundColor: AppColors.mainIcon,
                                color: AppColors.mainColor,
                                strokeWidth: 1.w)),
                        SizedBox(height: 6.h),
                        getSpan('加载中...', color: AppColors.secondText),
                      ]))
                    : Column(
                        children: controller.state.showList
                            .map((item) => getButtonList(
                                onPressed: () {
                                  controller.handleChooise(item);
                                },
                                title: Get.locale == const Locale('zh', 'CN')
                                    ? '+${item['area_code']}      ${item['op_name']}'
                                    : '+${item['area_code']}      ${item['country']}',
                                iconRight: Icon(Icons.check_circle,
                                    size: 9.w,
                                    color: '${item['area_code']}' ==
                                            controller.arguments
                                        ? AppColors.mainColor
                                        : AppColors.thirdIcon)))
                            .toList()),
              ),
            ),
          )
        ],
      ),
    );

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
