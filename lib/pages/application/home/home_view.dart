import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/pages/application/home/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// AppBar
    AppBar appBar = getMainBar();

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
