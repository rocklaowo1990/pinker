import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/setting/library.dart';

import 'package:pinker/pages/setting/verify/library.dart';

import 'package:pinker/utils/utils.dart';

import 'package:pinker/widgets/widgets.dart';

class SetVerifyController extends GetxController {
  final state = SetVerifyState();
  final arguments = Get.arguments;

  final ApplicationController applicationController = Get.find();
  final SettingController settingController = Get.find();

  late String codeData; //服务器发过来的验证码
  int? verifyType; //验证码类型（ID专用）

  void next() async {
    ResponseEntity responseEntity = arguments['verifyType'] == 3
        ? await AccountApi.deleteAccount(
            code: codeData,
            password: arguments['password'],
          )
        : arguments['accountType'] == 1
            ? await UserApi.setMobile(
                mobile: arguments['account'],
                areaCode: arguments['areaCode'],
                code: codeData,
                password: arguments['password'],
              )
            : await UserApi.setEmail(
                password: arguments['password'],
                code: codeData,
                email: arguments['account'],
              );

    if (responseEntity.code == 200) {
      if (arguments['verifyType'] == 3) {
        goLoginPage();
      } else {
        applicationController.state.userInfo.update((val) {
          arguments['accountType'] == 1
              ? val!.phone = arguments['account']
              : val!.email = arguments['account'];
        });

        // await StorageUtil().setJSON(
        //     storageUserInfoKey, applicationController.state.userInfo.value);

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
    /// 请求服务器...
    ResponseEntity codeNumber = arguments['verifyType'] == 3
        ? await CommonApi.sendSmsByType(
            userId: arguments['userId'],
            verifyType: arguments['verifyType'],
          )
        : arguments['accountType'] == 1
            ? await CommonApi.sendSms(
                mobile: arguments['account'],
                areaCode: arguments['areaCode'],
                entryType: arguments['entryType'],
              )
            : await CommonApi.sendEmail(
                email: arguments['account'],
                entryType: arguments['entryType'],
              );

    /// 返回数据处理
    if (codeNumber.code == 200) {
      if (codeNumber.data['status'] == 1) {
        state.account =
            '尾号 ${getLastTwo(applicationController.state.userInfo.value.phone)} 的手机';
        verifyType = codeNumber.data['status'];
      } else if (codeNumber.data['status'] == 2) {
        state.account =
            '尾号 ${getEmailHide(applicationController.state.userInfo.value.email)} 的邮箱';
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
    ResponseEntity checkCode = arguments['verifyType'] == 3
        ? await CommonApi.checkCodeByType(
            code: code, verifyType: verifyType!, userId: arguments['userId'])
        : await CommonApi.checkCode(
            code: code,
            account: arguments['account'],
            accountType: arguments['accountType'],
            entryType: arguments['entryType'],
          ); // 弹窗停留时间

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
