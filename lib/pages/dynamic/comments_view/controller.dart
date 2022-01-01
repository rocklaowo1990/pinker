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

  void handleMail() {}

  void init(Rx<ContentListEntities> contentList, int index) {
    _refresh(contentList, index);
  }

  void onRefresh(Rx<ContentListEntities> contentList, int index) async {
    refreshController.resetNoData();

    await futureMill(300);
    _refresh(contentList, index);
    await futureMill(300);

    refreshController.refreshCompleted();
  }

  void onLoading(Rx<ContentListEntities> contentList, int index) async {
    await futureMill(300);
    print(state.commentList.value.totalSize);
    if (state.commentList.value.totalSize >= 20) {
      pageIndex++;
      Map<String, dynamic> data = {
        'wid': contentList.value.list[index].wid,
        'pageNo': pageIndex,
        'pageSize': 20,
      };

      ResponseEntity responseEntity = await ContentApi.commentsList(data);

      if (responseEntity.code == 200) {
        CommentsListEntities _commentList =
            CommentsListEntities.fromJson(responseEntity.data);

        state.commentList.value.list.addAll(_commentList.list);
        state.commentList.value.totalSize = _commentList.totalSize;

        state.isLoading = false;
        state.commentList.update((val) {});

        refreshController.loadComplete();
      } else {
        pageIndex--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> _refresh(Rx<ContentListEntities> contentList, int index) async {
    pageIndex = 1;

    Map<String, dynamic> data = {
      'wid': contentList.value.list[index].wid,
      'pageNo': pageIndex,
      'pageSize': 20,
    };

    ResponseEntity responseEntity = await ContentApi.commentsList(data);
    if (responseEntity.code == 200) {
      CommentsListEntities commentList =
          CommentsListEntities.fromJson(responseEntity.data);

      state.commentList.update((val) {
        val!.list.clear();
        val.list.addAll(commentList.list);
      });

      state.commentList.update((val) {});

      state.isLoading = false;
    } else {
      getSnackTop(responseEntity.msg);
      state.isLoading = false;
    }
  }
}
