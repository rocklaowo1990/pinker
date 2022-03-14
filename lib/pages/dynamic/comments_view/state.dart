import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

class CommentsViewState {
  final commentList =
      CommentsListEntities.fromJson(CommentsListEntities.child).obs;

  /// 正在请求数据:最新
  final RxBool _isLoading = true.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  /// 回复对象的昵称
  final RxString _replyUserName = ''.obs;
  set replyUserName(String value) => _replyUserName.value = value;
  String get replyUserName => _replyUserName.value;

  /// 按钮禁用
  final _isDisplay = false.obs;
  set isDisplay(bool value) => _isDisplay.value = value;
  bool get isDisplay => _isDisplay.value;
}
