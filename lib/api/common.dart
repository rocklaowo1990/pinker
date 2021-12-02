import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class CommonApi {
  /// 注册获取验证码：手机
  static Future sendSms(data) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var response = await HttpUtil().postForm(
      '/api/common/sendSms',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': Global.platform,
        'osversion': Global.osversion,
        'version': Global.packageInfo?.version,
        'model': Global.model,
        'timestamp': timestamp,
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 注册获取验证码：邮箱
  static Future sendEmail(data) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var response = await HttpUtil().postForm(
      '/api/common/sendEmail',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': Global.platform,
        'osversion': Global.osversion,
        'version': Global.packageInfo?.version,
        'model': Global.model,
        'timestamp': timestamp,
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 发送验证码(userid)
  static Future sendSmsByType(data) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var response = await HttpUtil().postForm(
      '/api/common/sendSmsByType',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': Global.platform,
        'osversion': Global.osversion,
        'version': Global.packageInfo?.version,
        'model': Global.model,
        'timestamp': timestamp,
        'token': Global.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 发送验证码(userid)
  static Future checkCodeByType(data) async {
    var response = await HttpUtil().postForm(
      '/api/common/checkCodeByType',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 验证验证码：注册
  static Future checkCode(data) async {
    var response = await HttpUtil().postForm(
      '/api/common/checkCode',
      data: data,
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
