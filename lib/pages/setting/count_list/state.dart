import 'package:get/get.dart';

class SetCountListState {
  /// 列表数组
  final RxList _showList = [].obs;
  set showList(List value) => _showList.value = value;
  List get showList => _showList;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  /// 字符串检索
  final RxString searchRx = ''.obs;
  set searchValue(String value) => searchRx.value = value;
  String get searchValue => searchRx.value;
}
