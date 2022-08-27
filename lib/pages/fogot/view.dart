import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/routes/routes.dart';

import 'package:pinker/values/colors.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({Key? key, this.arguments}) : super(key: key);
  final String? arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
        init: ForgotController(arguments),
        builder: (controller) {
          /// appbar
          AppBar appBar = getAppBar(
            getSpanTitle('找回密码'),
            backgroundColor: AppColors.mainBacground,
            leading: getCloseButton(
              onPressed: controller.handleBack,
            ),
          );

          /// body布局
          Widget body = Column(
            children: [
              Container(
                child: const SafeArea(
                  child: SizedBox(),
                ),
                color: AppColors.mainBacground,
              ),
              appBar,
              Container(height: 1, color: AppColors.secondBacground),
              Expanded(
                child: Container(
                  color: AppColors.mainBacground,
                  child: Navigator(
                    key: Get.nestedKey(3),
                    initialRoute: arguments == null
                        ? AppRoutes.forgotIndex
                        : AppRoutes.forgotType,
                    onGenerateRoute: controller.onGenerateRoute,
                  ),
                ),
              ),
            ],
          );
          return body;
        });
  }
}
