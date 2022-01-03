import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class HomeState {
  final contentList =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  /// 正在请求数据
  final RxBool isLoadingRx = true.obs;
  set isLoading(bool value) => isLoadingRx.value = value;
  bool get isLoading => isLoadingRx.value;
}
