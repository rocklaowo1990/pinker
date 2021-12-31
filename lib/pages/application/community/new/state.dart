import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class ContentListNewState {
  final contentList =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
