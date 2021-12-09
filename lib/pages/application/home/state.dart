import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class HomeState {
  /// 检索后，用来显示的列表
  final RxList<ListElement> _showList = <ListElement>[].obs;
  set showList(value) => _showList.value = value;
  RxList<ListElement> get showList => _showList;

  /// 正在请求数据
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
}
