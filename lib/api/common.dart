import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/store/store.dart';
import 'package:pinker/utils/utils.dart';

class CommonApi {
  /// 注册获取验证码：手机
  static Future sendSms({
    required String mobile,
    required String areaCode,
    required int entryType,
  }) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var response = await HttpUtil().postForm(
      '/api/common/sendSms',
      data: {
        'mobile': mobile,
        'areaCode': areaCode,
        'entryType': entryType,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': ConfigStore.to.platform,
        'osversion': ConfigStore.to.osversion,
        'version': ConfigStore.to.packageInfo?.version,
        'model': ConfigStore.to.model,
        'timestamp': timestamp,
        'token': UserStore.to.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 注册获取验证码：邮箱
  static Future sendEmail({
    required String email,
    required int entryType,
  }) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var response = await HttpUtil().postForm(
      '/api/common/sendEmail',
      data: {
        'email': email,
        'entryType': entryType,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': ConfigStore.to.platform,
        'osversion': ConfigStore.to.osversion,
        'version': ConfigStore.to.packageInfo?.version,
        'model': ConfigStore.to.model,
        'timestamp': timestamp,
        'token': UserStore.to.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 发送验证码(userid)
  static Future sendSmsByType({
    required int userId,
    required int verifyType,
  }) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var response = await HttpUtil().postForm(
      '/api/common/sendSmsByType',
      data: {
        'userId': userId,
        'verifyType': verifyType,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': ConfigStore.to.platform,
        'osversion': ConfigStore.to.osversion,
        'version': ConfigStore.to.packageInfo?.version,
        'model': ConfigStore.to.model,
        'timestamp': timestamp,
        'token': UserStore.to.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 发送验证码(userid)
  static Future checkCodeByType({
    required String code,
    required int userId,
    required int verifyType,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/common/checkCodeByType',
      data: {'userId': userId, 'verifyType': verifyType, 'code': code},
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 验证验证码：注册
  static Future checkCode({
    required String code,
    required int accountType,
    required int entryType,
    required String account,
  }) async {
    var response = await HttpUtil().postForm(
      '/api/common/checkCode',
      data: {
        'code': code,
        'accountType': accountType,
        'entryType': entryType,
        'account': account,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 获取区号
  static Future getAreaCodeList() async {
    var response = await HttpUtil().get(
      '/api/common/getAreaCodeList',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 上传文件资源验证
  static Future verifyResource(data, {required String token}) async {
    var response = await HttpUtil().postForm(
      '/api/common/verifyResource',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 上传文件
  static Future uploadFile({
    required String token,
    required String filePath,
    required String fileName,

    /// 文件类型（1-图片；2-视频；3语音）
    required String type,
    void Function(int, int)? onSendProgress,
  }) async {
    Map<String, dynamic> data = {
      'type': type,
      'file': await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    };
    var response = await HttpUtil().postForm(
      '/api/common/uploadFile',
      data: data,
      options: Options(headers: {
        'Content-Type': 'multipart/form-data',
        'token': token,
      }),
      onSendProgress: onSendProgress,
    );
    return ResponseEntity.fromJson(response);
  }
}
