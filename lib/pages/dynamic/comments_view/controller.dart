import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/comments_view/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentsViewController extends GetxController {
  final CommentsViewState state = CommentsViewState();
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();

  int pageIndex = 1;
  int totalSize = 0;

  int replyId = 0;

  Future<void> onRefresh(
      ListElement item, ContentBoxController contentBoxController) async {
    await futureMill(300);
    _refresh(item, contentBoxController);
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  Future<void> _refresh(
      ListElement item, ContentBoxController contentBoxController) async {
    pageIndex = 1;
    totalSize = 0;

    Map<String, dynamic> data = {
      'wid': item.wid,
      'pageNo': pageIndex,
      'pageSize': 20,
    };

    ResponseEntity responseEntity = await ContentApi.commentsList(data);

    if (responseEntity.code == 200) {
      CommentsListEntities commentsList =
          CommentsListEntities.fromJson(responseEntity.data);

      state.showList.clear();

      state.showList.addAll(commentsList.list);
      state.isLoading = false;
      totalSize = commentsList.totalSize;

      contentBoxController.state.commentCount = state.showList.length;
    } else {
      state.isLoading = false;

      getSnackTop(responseEntity.msg);
    }
  }

  Map<String, dynamic> data = {
    'pageNo': 1,
    'pageSize': 20,
  };

  Future<void> onLoading(
      ListElement item, ContentBoxController contentBoxController) async {
    await futureMill(300);
    if (totalSize >= 20) {
      pageIndex++;
      Map<String, dynamic> data = {
        'pageNo': pageIndex,
        'pageSize': 20,
      };

      ResponseEntity responseEntity = await ContentApi.commentsList(data);

      if (responseEntity.code == 200) {
        CommentsListEntities commentsList =
            CommentsListEntities.fromJson(responseEntity.data);

        state.showList.addAll(commentsList.list);
        state.isLoading = false;
        totalSize = commentsList.totalSize;

        contentBoxController.state.commentCount = state.showList.length;
      } else {
        pageIndex--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  void handleClearReplyId() {
    state.replyUserName = '';
    replyId = 0;
  }
}
