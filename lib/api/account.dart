import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/utils/utils.dart';

class AccountApi {
  /// 登陆API
  static Future<UserLoginResponseEntity> login({
    data,
  }) async {
    var response = await HttpUtil().post(
      '/api/account/login',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return UserLoginResponseEntity.fromJson(response);
  }

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
    return UserLoginResponseEntity.fromJson(response);
  }
}
