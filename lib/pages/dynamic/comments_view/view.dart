import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/comments_view/controller.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Future getCommentsView(ListElement item) {
  Widget child = GetBuilder<CommentsViewController>(
    init: CommentsViewController(item),
    builder: (controller) {
      // 初始化
      // 这种结构的只能在这里初始化
      // 在里面初始化需要在控制器里面加入index变量

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
        () => controller.state.showList.isEmpty
            ? noData
            : getRefresher(
                controller: controller.refreshController,
                scrollController: controller.scrollController,
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.state.showList
                        .map((index) => SizedBox(
                              child: index.replyUser != null
                                  ? getSpan(index.replyUser!.userId.toString())
                                  : getSpan(index.author.userId.toString()),
                              height: 100,
                              width: double.infinity,
                            ))
                        .toList(),
                  ),
                ),
                onLoading: () {
                  // controller.onLoading();
                },
                onRefresh: () {
                  // controller.onRefresh();
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
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(9.w, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getSpan('条评论'),
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
                  Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: getInput(
                              height: 40,
                              type: '文明回复，共创美好环境 ~',
                              controller: TextEditingController(),
                              focusNode: FocusNode(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          getButton(
                            child: getSpan('回复'),
                            height: 40,
                            width: 80,
                          ),
                        ],
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
