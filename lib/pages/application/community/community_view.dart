import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/pages/application/community/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// AppBar
    AppBar appBar = getAppBar(
      getSpan('Community'),
      elevation: 0.5.w,
      backgroundColor: AppColors.mainBacground,
    );

    /// body
    Widget body = Container();

    /// 页面
    return Scaffold(
      backgroundColor: AppColors.mainBacground,
      appBar: appBar,
      body: body,
    );
  }
}
