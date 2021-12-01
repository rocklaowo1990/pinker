import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

class SubscribeGroupApi {
  /// 登陆API ///////////////////////////////////////////////////////////////////
  static Future<ResponseEntity> list({Map<String, dynamic>? data}) async {
    // 读取token
    String token = StorageUtil().getJSON(storageUserTokenKey);
    var response = await HttpUtil().get(
      '/api/subscribeGroup/list',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      }),
      queryParameters: data,
    );
    return ResponseEntity.fromJson(response);
  }
}
