import 'package:get/get.dart';

class ContentListSearchVideoState {
  /// 加载中
  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
