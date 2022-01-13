import 'package:get/get.dart';

class ContentListSearchFreeState {
  /// 加载中
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
