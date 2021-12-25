import 'package:get/get.dart';

import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/comments_view/comment_item/library.dart';

class CommentItemController extends GetxController {
  CommentItemController(this.item);
  final ListElementComments item;
  final CommentItemState state = CommentItemState();

  void onComment() {}

  void onLike() {}

  // 初始化数据
  // 暂时还不知道为啥要在这里初始化
  void initState(ListElementComments item) {
    state.commentCount = item.commentCount;
    state.isLike = item.isLike;
    state.likeCount = item.likeCount;
  }
}
