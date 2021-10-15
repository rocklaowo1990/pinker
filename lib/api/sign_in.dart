import 'package:dio/dio.dart';
import 'package:pinker/utils/utils.dart';

class AccountApi {
  static Future signIn({
    data,
  }) async {
    var response = await HttpUtil().post(
      '/api/account/login',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    return response;
  }
}
