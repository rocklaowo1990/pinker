import 'package:get/get.dart';

class CodeListState {
  /// 检索后，用来显示的列表
  final RxList<dynamic> _showList = [].obs;
  set showList(List value) => _showList.value = value;
  List<dynamic> get showList => _showList;

  /// 字符串检索
  final RxString searchRx = ''.obs;
  set searchValue(String value) => searchRx.value = value;
  String get searchValue => searchRx.value;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
