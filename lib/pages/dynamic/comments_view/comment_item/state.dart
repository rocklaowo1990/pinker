import 'package:get/get.dart';

class CommentItemState {
  /// 这条评论的评论数量，不是推文作者的哦，是这条评论的评论数量
  final RxInt _commentCount = 0.obs;
  set commentCount(int value) => _commentCount.value = value;
  int get commentCount => _commentCount.value;

  /// 这条评论的喜欢数量，不是推文作者的哦，是这条评论的喜欢喜欢喜欢
  final RxInt _likeCount = 0.obs;
  set likeCount(int value) => _likeCount.value = value;
  int get likeCount => _likeCount.value;

  // 是否已点赞
  final RxInt _isLike = 0.obs;
  set isLike(int value) => _isLike.value = value;
  int get isLike => _isLike.value;
}
