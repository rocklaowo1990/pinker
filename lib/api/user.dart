import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

class UserApi {
  /// 获取用户列表
  static Future<ResponseEntity> recommendUserList(data) async {
    /// 读取token
    var _profileJSON = StorageUtil().getJSON(storageUserProfileKey);
    if (_profileJSON != null) Global.token = _profileJSON['data']['token'];

    /// 请求
    var response = await HttpUtil().get(
      '/api/user/recommendUserList',
      queryParameters: data,
      options: Options(headers: {
        'token': Global.token,
      }),
    );

    return ResponseEntity.fromJson(response);
  }
}
