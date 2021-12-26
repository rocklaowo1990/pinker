import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/comments_view/comment_item/library.dart';
import 'package:pinker/pages/dynamic/comments_view/library.dart';

class CommentItemController extends GetxController {
  final CommentItemState state = CommentItemState();

  void onComment(
      ListElementComments item, CommentsViewController commentsViewController) {
    commentsViewController.state.replyUserName = item.author.userName;
    commentsViewController.replyId = item.author.userId;
    commentsViewController.focusNode.requestFocus();
  }

  void onLike() {
    state.isLike = state.isLike == 0 ? 1 : 0;
    state.isLike == 0 ? state.likeCount-- : state.likeCount++;
  }

  // 初始化数据
  // 暂时还不知道为啥要在这里初始化
  void initState(ListElementComments item) {
    state.commentCount = item.commentCount;
    state.isLike = item.isLike;
    state.likeCount = item.likeCount;
  }
}
