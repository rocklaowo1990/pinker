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
    /// appBar
    AppBar appBar = getAppBar(
      getSpan(Lang.codeTitle.tr, fontSize: 17),
      backgroundColor: AppColors.secondBacground,
      elevation: 0.5.h,
    );

    /// body
    Widget body = Scrollbar(
      child: Obx(
        () => ListView(
          children: controller.state.codeList
              .map((item) => getButtonList(
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
                            '${item['area_code']}'
                        ? AppColors.mainColor
                        : AppColors.thirdIcon,
                  )))
              .toList(),
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
