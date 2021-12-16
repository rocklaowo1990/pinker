import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/pages/setting/library.dart';

import 'package:pinker/pages/setting/verify/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class SetVerifyController extends GetxController {
  final state = SetVerifyState();
  final arguments = Get.arguments;

  final SettingController settingController = Get.find();
  final MyController myController = Get.find();

  late String codeData; //服务器发过来的验证码
  int? verifyType; //验证码类型（ID专用）

  void next() async {
    /// 准备请求数据
    Map<String, dynamic> data = {};

    if (arguments['accountType'] == '1') {
      data = {
        'mobile': arguments['account'],
        'areaCode': arguments['areaCode'],
        'code': codeData,
        'password': arguments['password'],
      };
    } else if (arguments['accountType'] == '2') {
      data = {
        'email': arguments['account'],
        'code': codeData,
        'password': arguments['password'],
      };
    } else {
      data = {
        'code': codeData,
        'password': arguments['password'],
      };
    }

    ResponseEntity responseEntity = arguments['verifyType'] == 3
        ? await AccountApi.deleteAccount(data)
        : arguments['accountType'] == '1'
            ? await UserApi.setMobile(data)
            : await UserApi.setEmail(data);

    if (responseEntity.code == 200) {
      if (arguments['verifyType'] == 3) {
        goLoginPage();
      } else {
        arguments['accountType'] == '1'
            ? myController.state.phone = arguments['account']
            : myController.state.email = arguments['account'];
        if (settingController.arguments != null) {
          UserInfo _userInfo = settingController.arguments!;
          (arguments['accountType'] == '1')
              ? _userInfo.phone = arguments['account']
              : _userInfo.email = arguments['account'];

          await StorageUtil().setJSON(storageUserInfoKey, _userInfo);
        }

        Get.back(); // 返回更换手机号码
        Get.back(); // 返回验证密码
        Get.back(); // 返回设置页面
        getSnackTop('修改成功', isError: false);
      }
    } else {
      Get.back(); // 返回更换手机号码
      getSnackTop(responseEntity.msg);
    }
  }

  /// 请求验证码
  Future<bool> sendCode() async {
    /// 准备请求数据
    Map<String, dynamic> data = {};

    if (arguments['accountType'] == '1') {
      data = {
        'mobile': arguments['account'],
        'areaCode': arguments['areaCode'],
        'entryType': arguments['entryType'],
      };
    } else if (arguments['accountType'] == '2') {
      data = {
        'email': arguments['account'],
        'entryType': arguments['entryType'],
      };
    } else {
      data = {
        'userId': arguments['userId'],
        'verifyType': arguments['verifyType'],
      };
    }

    /// 请求服务器...
    ResponseEntity codeNumber = arguments['verifyType'] == 3
        ? await CommonApi.sendSmsByType(data)
        : arguments['accountType'] == '1'
            ? await CommonApi.sendSms(data)
            : await CommonApi.sendEmail(data);

    /// 返回数据处理
    if (codeNumber.code == 200) {
      if (codeNumber.data['account'] != null) {
        state.account = codeNumber.data['account'];
        verifyType = codeNumber.data['status'];
      }
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
    Map<String, dynamic> data = arguments['verifyType'] == 3
        ? {
            'code': code,
            'verifyType': verifyType,
            'userId': arguments['userId'],
          }
        : {
            'account': arguments['account'],
            'accountType': arguments['accountType'],
            'code': code,
            'entryType': arguments['entryType'],
          };
    ResponseEntity checkCode = arguments['verifyType'] == 3
        ? await CommonApi.checkCodeByType(data)
        : await CommonApi.checkCode(data); // 弹窗停留时间

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
