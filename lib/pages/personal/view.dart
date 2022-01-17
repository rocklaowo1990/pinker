import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/personal/library.dart';

import 'package:pinker/values/colors.dart';

import 'package:pinker/values/values.dart';

class PersonalView extends StatelessWidget {
  const PersonalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalController>(
      init: PersonalController(),
      builder: (controller) {
        /// body
        Widget body = Container();

        /// 页面
        return Scaffold(
          backgroundColor: AppColors.mainBacground,
          body: body,
        );
      },
    );
  }
}
