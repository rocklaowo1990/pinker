import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class CommentsViewState {
  /// 推文列表:最新
  final RxList<ListElementComments> _showList = <ListElementComments>[].obs;
  set showList(value) => _showList.value = value;
  RxList<ListElementComments> get showList => _showList;

  /// 正在请求数据:最新
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  /// 回复对象的昵称
  final RxString _replyUserName = ''.obs;
  set replyUserName(String value) => _replyUserName.value = value;
  String get replyUserName => _replyUserName.value;
}
