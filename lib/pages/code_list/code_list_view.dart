import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/code_list/library.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CodeListView extends GetView<CodeListController> {
  const CodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// appBar 左侧的返回按钮
    Widget buttonBox = getButton(
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 9.w,
        color: AppColors.mainIcon,
      ),
      onPressed: controller.handleBack,
      background: Colors.transparent,
    );

    /// appBar
    AppBar appBar = getAppBar(
      leading: buttonBox,
      title: getSpan(Lang.codeTitle.tr, size: 10.sp),
      backgroundColor: AppColors.secondBacground,
      elevation: 0.5.h,
    );

    /// body
    Widget body = Scrollbar(
      child: Obx(
        () => Scrollbar(
          child: ListView(
            children: controller.state.codeList
                .map((item) => getList(
                    onPressed: () {
                      controller.handleChooise(item);
                    },
                    title: Get.locale == const Locale('zh', 'CN')
                        ? '+${item['area_code']}      ${item['op_name']}'
                        : '+${item['area_code']}      ${item['country']}',
                    iconRight: Icon(
                      Icons.check_circle,
                      size: 9.w,
                      color: controller.registerController.state.code ==
                              '+${item['area_code']}'
                          ? AppColors.mainColor
                          : AppColors.thirdIcon,
                    )))
                .toList(),
          ),
        ),
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
