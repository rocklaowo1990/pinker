import 'package:get/get.dart';

class ContentBoxState {
  // 是否显示资源的状态管理器
  final RxInt _canSee = 0.obs;
  set canSee(int value) => _canSee.value = value;
  int get canSee => _canSee.value;

  // 点赞的数量
  final RxInt _likeCount = 0.obs;
  set likeCount(int value) => _likeCount.value = value;
  int get likeCount => _likeCount.value;

  // 留言的数量
  final RxInt _commentCount = 0.obs;
  set commentCount(int value) => _commentCount.value = value;
  int get commentCount => _commentCount.value;

  // 转发的数量
  final RxInt _forwardCount = 0.obs;
  set forwardCount(int value) => _forwardCount.value = value;
  int get forwardCount => _forwardCount.value;

  // 是否已点赞
  final RxInt _isLike = 0.obs;
  set isLike(int value) => _isLike.value = value;
  int get isLike => _isLike.value;

  // 是否已转发
  final RxInt _isForward = 0.obs;
  set isForward(int value) => _isForward.value = value;
  int get isForward => _isForward.value;

  // 是否已经订阅
  // 是否已转发
  final RxInt _subStatus = 0.obs;
  set subStatus(int value) => _subStatus.value = value;
  int get subStatus => _subStatus.value;
}
