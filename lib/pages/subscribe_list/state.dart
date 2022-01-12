import 'package:get/get.dart';
import 'package:pinker/entities/subscribe_list.dart';

class SubscribeListState {
  /// 正在请求数据:最新
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  final subscribeList =
      SubscribeListEntities.fromJson(SubscribeListEntities.child).obs;
}
