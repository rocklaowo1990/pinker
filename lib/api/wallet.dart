import 'package:dio/dio.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/store/store.dart';
import 'package:pinker/utils/utils.dart';

class WalletApi {
  /// 充值（测试用）
  ///
  /// type:账户类型(1:钻石账户，2：P币账户 3：USDT 4：BTC 5:ETH)
  static Future<ResponseEntity> testAddMoney({
    required int type,
  }) async {
    // 请求
    var response = await HttpUtil().postForm(
      '/api/wallet/testAddMoney',
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': UserStore.to.token,
      }),
      data: {
        'type': type,
        'amount': 1000,
      },
    );

    return ResponseEntity.fromJson(response);
  }
}
