import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/pages/dynamic/comments_view/library.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentsViewController extends GetxController {
  CommentsViewController(this.item);
  final ListElement item;
  final CommentsViewState state = CommentsViewState();
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  int pageIndex = 1;
  int totalSize = 0;

  Future<void> onRefresh() async {
    await futureMill(500);
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await futureMill(500);
    refreshController.loadNoData();
  }

  @override
  void onReady() async {
    super.onReady();
    Map<String, dynamic> data = {
      'wid': item.wid,
      'pageNo': pageIndex,
      'pageSize': 20,
    };

    ResponseEntity responseEntity = await ContentApi.commentsList(data);

    if (responseEntity.code == 200) {
      CommentsList commentsList = CommentsList.fromJson(responseEntity.data);

      state.isLoading = false;
      state.showList.addAll(commentsList.list);
    } else {
      state.isLoading = false;

      getSnackTop(responseEntity.msg);
    }
  }
}
