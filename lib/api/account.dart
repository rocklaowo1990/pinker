import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/utils/utils.dart';

class AccountApi {
  /// 登陆API
  static Future<ResponseEntity> login(data) async {
    var response = await HttpUtil().post(
      '/api/account/login',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return ResponseEntity.fromJson(response);
  }

  /// 检查账号是否重复
  static Future<ResponseEntity> checkAccount(data) async {
    var response = await HttpUtil().get(
      '/api/account/checkAccountExist',
      queryParameters: data,
    );
    return ResponseEntity.fromJson(response);
  }
}
