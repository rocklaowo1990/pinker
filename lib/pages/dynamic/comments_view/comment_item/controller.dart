import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/comments_view/comment_item/state.dart';
import 'package:pinker/pages/dynamic/comments_view/library.dart';

class CommentListController extends GetxController {
  final CommentListState state = CommentListState();
  final CommentsViewController commentsViewController = Get.find();
  void handleReply(Rx<CommentsListEntities> commentList, int index) {
    commentsViewController.beUserId =
        commentList.value.list[index].author.userId;
    commentsViewController.cid = commentList.value.list[index].cid;
    commentsViewController.state.replyUserName =
        commentList.value.list[index].author.userName;
    commentsViewController.focusNode.requestFocus();
  }
}
