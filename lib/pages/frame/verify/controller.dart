import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/pages/frame/verify/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class VerifyController extends GetxController {
  /// 遮罩控制器
  final FrameController frameController = Get.find();

  /// 状态管理
  final VerifyState state = VerifyState();

  /// 上一页传参
  final Map<String, dynamic> arguments = Get.arguments;

  void next() {
    frameController.state.pageIndex = -1; // 下一页不需要返回
    Get.offAllNamed(AppRoutes.password, id: 1, arguments: arguments);
  }

  /// 请求验证码
  Future<bool> sendCode() async {
    /// 准备请求数据
    Map<String, String> data = {};

    if (arguments['accountType'] == '1') {
      data = {
        'mobile': arguments['account'],
        'areaCode': arguments['areaCode'],
        'entryType': arguments['entryType'],
      };
    } else {
      data = {
        'email': arguments['account'],
        'entryType': arguments['entryType'],
      };
    }

    /// 请求服务器...
    ResponseEntity codeNumber = arguments['accountType'] == '1'
        ? await CommonApi.sendSms(data)
        : await CommonApi.sendEmail(data);

    /// 返回数据处理
    if (codeNumber.code == 200) {
      getSnackTop(
        Lang.codeSussful.tr,
        isError: false,
      );
      frameController.state.sendTime = 60;
      return true;
    } else {
      /// 返回错误信息
      // getSnackTop(codeNumber.msg);
      return false;
    }
  }

  /// 验证验证码
  Future<bool> isVerify(String code) async {
    Map<String, dynamic> data = {
      'account': arguments['account'],
      'accountType': arguments['accountType'],
      'code': code,
      'entryType': arguments['entryType'],
    };
    ResponseEntity checkCode = await CommonApi.checkCode(data); // 弹窗停留时间

    if (checkCode.code == 200) {
      arguments['code'] = code;
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
    sendCode();
  }

  @override
  void dispose() {
    frameController.dispose();

    super.dispose();
  }
}
