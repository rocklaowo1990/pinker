import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/store/store.dart';
import 'package:pinker/utils/utils.dart';

class ChatApi {
  /// 获取群列表
  static Future<ResponseEntity> groupList({
    required int pageNo,
    required int type,
  }) async {
    var response = await HttpUtil().get(
      '/api/chat/groupList',
      queryParameters: {
        'type': type,
        'pageNo': pageNo,
        'pageSize': 20,
      },
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': UserStore.to.token,
      }),
    );
    return ResponseEntity.fromJson(response);
  }
}
