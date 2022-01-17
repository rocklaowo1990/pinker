import 'package:get/get.dart';
import 'package:pinker/entities/subscribe_list.dart';

class SubscribeListState {
  /// 正在请求数据:最新
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  /// 正在订阅的用户
  final subscribeList =
      SubscribeListEntities.fromJson(SubscribeListEntities.child).obs;

  /// 开关控制器
  final RxInt _enable = 0.obs;
  set enable(int value) => _enable.value = value;
  int get enable => _enable.value;
}
