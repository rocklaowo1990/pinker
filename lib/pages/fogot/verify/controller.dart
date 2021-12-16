import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/fogot/library.dart';

import 'package:pinker/pages/fogot/verify/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotVerifyController extends GetxController {
  /// 状态控制器
  final ForgotVerifyState state = ForgotVerifyState();

  /// 主页面焦点
  final ForgotController forgotController = Get.find();

  void handleNext() {
    forgotController.state.pageIndex++;
    Get.offNamed(AppRoutes.forgotPassword, id: 3);
  }

  /// 请求验证码
  Future<bool> sendCode() async {
    /// 准备请求数据
    Map<String, dynamic> data = {
      'userId': forgotController.forgotInfo.userId,
      'verifyType': forgotController.state.verifyType,
    };

    /// 请求服务器...
    ResponseEntity codeNumber = await CommonApi.sendSmsByType(data);

    /// 返回数据处理
    if (codeNumber.code == 200) {
      getSnackTop(
        Lang.codeSussful.tr,
        isError: false,
      );

      forgotController.state.sendTime = 60;
      return true;
    } else {
      getSnackTop(codeNumber.msg);
      return false;
    }
  }

  /// 验证验证码
  Future<bool> isVerify(String code) async {
    Map<String, dynamic> data = {
      'code': code,
      'verifyType': forgotController.state.verifyType,
      'userId': forgotController.forgotInfo.userId,
    };

    ResponseEntity checkCode = await CommonApi.checkCodeByType(data); // 弹窗停留时间

    if (checkCode.code == 200) {
      forgotController.publicData['code'] = code;

      await futureMill(500);

      return true;
    } else {
      await futureMill(500);

      Get.back();
      getSnackTop(checkCode.msg);
      return false;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await sendCode();
    interval(forgotController.state.sendTimeRx, (value) {
      if (forgotController.state.sendTime > 0) {
        forgotController.state.sendTime--;
      }
    });
  }
}
