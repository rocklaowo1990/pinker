import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/pages/setting/library.dart';

import 'package:pinker/pages/setting/set_user_name/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetVerifyController extends GetxController {
  final state = SetUserNameState();
  final arguments = Get.arguments;

  final SettingController settingController = Get.find();
  final MyController myController = Get.find();

  late String codeData;

  void next() async {
    /// 准备请求数据
    Map<String, String> data = {};

    if (arguments['accountType'] == '1') {
      data = {
        'mobile': arguments['account'],
        'areaCode': arguments['areaCode'],
        'code': codeData,
        'password': arguments['password'],
      };
    } else {
      data = {
        'email': arguments['account'],
        'code': codeData,
        'password': arguments['password'],
      };
    }

    ResponseEntity responseEntity = (arguments['accountType'] == '1')
        ? await UserApi.setMobile(data)
        : await UserApi.setEmail(data);
    if (responseEntity.code == 200) {
      (arguments['accountType'] == '1')
          ? settingController.state.phone = arguments['account']
          : settingController.state.email = arguments['account'];
      if (settingController.arguments != null) {
        UserInfo _userInfo = settingController.arguments!;
        (arguments['accountType'] == '1')
            ? _userInfo.phone = arguments['account']
            : _userInfo.email = arguments['account'];
        await StorageUtil().setJSON(storageUserInfoKey, _userInfo);
        myController.userInfo = StorageUtil().getJSON(storageUserInfoKey);
      }

      Get.back(); // 返回更换手机号码
      Get.back(); // 返回验证密码
      Get.back(); // 返回设置页面
    } else {
      getSnackTop(responseEntity.msg);
    }
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
      settingController.state.sendTime = 60;
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
      codeData = code;
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
}
