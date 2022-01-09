import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

      Widget loading = Center(
          child: Column(children: [
        SizedBox(height: 40.h),
        SizedBox(
            width: 9.w,
            height: 9.w,
            child: CircularProgressIndicator(
                backgroundColor: AppColors.mainIcon,
                color: AppColors.mainColor,
                strokeWidth: 1.w)),
        SizedBox(height: 6.h),
        getSpan('加载中...', color: AppColors.secondText),
      ]));

      // 没有数据的时候，显示暂无数据
      Widget noData = Center(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            SvgPicture.asset(
              'assets/svg/error_4.svg',
              width: 55.w,
            ),
            SizedBox(height: 6.h),
            getSpan('暂无数据', color: AppColors.secondText),
          ],
        ),
      );

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
              decoration: BoxDecoration(
                  color: AppColors.mainBacground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.w),
                      topRight: Radius.circular(8.w))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(9.w, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => getSpan(
                            '${contentList.value.list[index].commentCount} 条评论')),
                        getButton(
                          child: const Icon(Icons.close,
                              color: AppColors.mainIcon),
                          background: Colors.transparent,
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
                            padding: EdgeInsets.only(left: 4.w),
                            child: getButton(
                                onPressed: controller.handleClearReply,
                                height: 30,
                                width: 200,
                                background: AppColors.line,
                                padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getSpan(
                                        '回复 ${controller.state.replyUserName}'),
                                    const Icon(
                                      Icons.close,
                                      color: AppColors.mainIcon,
                                      size: 17,
                                    ),
                                  ],
                                )),
                          )
                        : const SizedBox(),
                  ),
                  Obx(() => Padding(
                        padding: EdgeInsets.all(4.w),
                        child: contentList.value.list[index].canReply == 1
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: getInput(
                                      height: 40,
                                      type: '文明回复，共创美好环境 ~',
                                      controller: controller.textController,
                                      focusNode: controller.focusNode,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  getButton(
                                    child: getSpan('回复'),
                                    height: 40,
                                    width: 70,
                                    onPressed: () {
                                      controller.handleCommentAdd(
                                          contentList, index,
                                          storageKey: storageKey);
                                    },
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: Center(
                                  child: getSpan(
                                    '您没有权限回复这篇推文',
                                    color: AppColors.secondText,
                                  ),
                                ),
                              ),
                      )),
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
