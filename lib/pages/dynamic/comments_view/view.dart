import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/comments_view/comment_item/library.dart';

import 'package:pinker/pages/dynamic/comments_view/controller.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Future getCommentsView(
  Rx<ContentListEntities> contentList,
  int index, {
  String? storageKey,
}) {
  Widget child = GetBuilder<CommentsViewController>(
    init: CommentsViewController(),
    builder: (controller) {
      // 初始化
      // 这种结构的只能在这里初始化
      // 在里面初始化需要在控制器里面加入index变量
      controller.init(contentList, index);

      Widget loading = getLoadingIcon();

      // 没有数据的时候，显示暂无数据
      Widget noData = getNoDataIcon();

      // 整体布局
      Widget _body = Obx(
        () => controller.state.commentList.value.list.isEmpty
            ? SingleChildScrollView(child: noData)
            : getRefresher(
                controller: controller.refreshController,
                child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.state.commentList.value.list.length,
                    itemBuilder:
                        (BuildContext buildContext, int indexComments) {
                      return getCommentList(
                          controller.state.commentList, indexComments,
                          wid: contentList.value.list[index].wid);
                    }),
                onLoading: () {
                  controller.onLoading(contentList, index);
                },
                isFooter: controller.state.commentList.value.list.length < 20
                    ? false
                    : true,
                onRefresh: () {
                  controller.onRefresh(contentList, index);
                },
              ),
      );

      /// body
      Widget body = Obx(() => controller.state.isLoading ? loading : _body);

      return Column(
        children: [
          getButton(
              width: double.infinity,
              background: Colors.transparent,
              overlayColor: Colors.transparent,
              height: 90,
              child: const SizedBox(),
              onPressed: () {
                Get.back();
              }),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.mainBacground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => getSpan(
                            '${contentList.value.list[index].commentCount} 条评论')),
                        getCloseButton(
                          onPressed: () {
                            Get.back();
                          },
                        )
                      ],
                    ),
                  ),
                  Container(height: 1, color: AppColors.line),
                  Expanded(
                    child: body,
                  ),
                  Container(height: 1, color: AppColors.line),
                  Obx(
                    () => controller.state.replyUserName.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: getButton(
                                onPressed: controller.handleClearReply,
                                height: 30,
                                width: 200,
                                background: AppColors.line,
                                padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getSpan(
                                        '回复 ${controller.state.replyUserName}'),
                                    const Icon(
                                      Icons.close,
                                      color: AppColors.mainIcon,
                                      size: 14,
                                    ),
                                  ],
                                )),
                          )
                        : const SizedBox(),
                  ),
                  SafeArea(
                    top: false,
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8),
                        child: contentList.value.list[index].canReply == 1
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: getInput(
                                      height: 48,
                                      type: '文明回复，共创美好环境 ~',
                                      controller: controller.textController,
                                      focusNode: controller.focusNode,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Obx(
                                    () => getButton(
                                      child: getSpan('回复'),
                                      background: controller.state.isDisplay
                                          ? AppColors.mainColor
                                          : AppColors.buttonDisable,
                                      height: 48,
                                      width: 70,
                                      onPressed: controller.state.isDisplay
                                          ? () {
                                              controller.handleCommentAdd(
                                                  contentList, index,
                                                  storageKey: storageKey);
                                            }
                                          : null,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: Center(
                                  child: getSpan(
                                    '您没有权限回复这篇推文',
                                    color: AppColors.secondText,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
  return Get.bottomSheet(
    child,
    isScrollControlled: true,
  );
}
