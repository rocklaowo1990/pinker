import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class CommonApi {
  /// 注册获取验证码
  static Future sendSms({
    data,
  }) async {
    DateTime timestamp = DateTime.now();
    var response = await HttpUtil().post(
      '/api/common/sendSms',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'platform': Global.platform,
        'osversion': Global.osversion,
        'version': Global.packageInfo?.version,
        'model': Global.model,
        'timestamp': '$timestamp',
        'token': Global.token ?? '',
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
}
