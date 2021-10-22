import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/frame/index.dart';
import 'package:pinker/pages/frame/verify/index.dart';
import 'package:pinker/widgets/widgets.dart';

class VerifyController extends GetxController {
  /// 遮罩控制器
  final frameController = Get.put(FrameController());
  final state = VerifyState();

  final data = Get.arguments;
  DateTime? sendTime;
  late ResponseEntity userProfile;

  @override
  void onInit() async {
    if (sendTime == null) {
      debugPrint('请求开始');

      debugPrint(data.toString());

      /// 请求服务器...
      userProfile = await CommonApi.sendSms(data: data);

      /// 返回数据处理
      if (userProfile.code == 200) {
        getSnackTop(msg: userProfile.msg);
      } else {
        /// 返回错误信息
        await Future.delayed(const Duration(milliseconds: 200), () {
          getSnackTop(msg: userProfile.msg);
        });
      }
    }

    super.onInit();
  }
}
