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

  int pageNo = 1;
  int? beUserId;
  int? cid;

  void handleMail() {}

  void handleClearReply() {
    beUserId = 0;
    cid = 0;
    state.replyUserName = '';
    focusNode.unfocus();
  }

  void handleCommentAdd(
    Rx<ContentListEntities> contentList,
    int index, {
    String? storageKey,
  }) async {
    focusNode.unfocus();

    getDialog();

    ResponseEntity responseEntity = await ContentApi.commentsAdd(
      wid: contentList.value.list[index].wid,
      content: textController.text,
      cid: cid,
      beUserId: beUserId,
    );
    if (responseEntity.code == 200) {
      _refresh(contentList, index);
      contentList.update((val) {
        val!.list[index].commentCount++;
      });

      if (storageKey != null) {
        await StorageService.to
            .setString(storageKey, contentList.value.toString());
      }
      textController.clear();
      Get.back();
      getContentOnly(wid: contentList.value.list[index].wid);
    } else {
      getSnackTop(responseEntity.msg);
    }
  }

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

    if (state.commentList.value.totalSize >= 20) {
      pageNo++;

      ResponseEntity responseEntity = await ContentApi.commentsList(
        wid: contentList.value.list[index].wid,
        pageNo: pageNo,
      );

      if (responseEntity.code == 200) {
        CommentsListEntities _commentList =
            CommentsListEntities.fromJson(responseEntity.data);
        state.commentList.update((val) {
          val!.list.addAll(_commentList.list);
        });

        state.isLoading = false;
        state.commentList.value.totalSize = _commentList.totalSize;
        refreshController.loadComplete();
      } else {
        pageNo--;
        refreshController.loadFailed();
        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> _refresh(Rx<ContentListEntities> contentList, int index) async {
    pageNo = 1;

    ResponseEntity responseEntity = await ContentApi.commentsList(
      wid: contentList.value.list[index].wid,
      pageNo: pageNo,
    );
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
