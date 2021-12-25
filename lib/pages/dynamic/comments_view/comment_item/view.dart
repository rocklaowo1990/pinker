import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/comments_view/comment_item/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getCommentItem(ListElementComments item) {
  return GetBuilder<CommentItemController>(
      init: CommentItemController(item),
      builder: (controller) {
        // 初始化
        // 这种结构的只能在这里初始化
        // 在里面初始化需要在控制器里面加入index变量
        controller.initState(item);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getImageBox(
              item.author.avatar,
              shape: BoxShape.circle,
              width: 50,
            ),
            SizedBox(width: 9.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSpan(item.author.nickName, fontSize: 17),
                  Row(
                    children: [
                      getSpan(
                        item.author.userName,
                        color: AppColors.secondText,
                      ),
                      const SizedBox(width: 8),
                      getButton(
                        child: getSpan('回复'),
                        height: 30,
                        background: Colors.transparent,
                        onPressed: controller.onComment,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  item.replyUser != null
                      ? RichText(
                          text: TextSpan(
                            text: '@${item.replyUser!.userName}  ',
                            style: const TextStyle(
                                color: AppColors.mainColor, fontSize: 15),
                            children: [
                              TextSpan(
                                text: item.content,
                                style: const TextStyle(
                                    color: AppColors.mainText, fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      : getSpan(item.content),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            getButton(
              width: 60,
              background: Colors.transparent,
              overlayColor: Colors.transparent,
              onPressed: controller.onLike,
              child: Column(
                children: [
                  controller.state.isLike == 0
                      ? SvgPicture.asset(
                          'assets/svg/icon_like.svg',
                          height: 9.w,
                        )
                      : SvgPicture.asset(
                          'assets/svg/icon_like_press.svg',
                          height: 9.w,
                        ),
                  const SizedBox(height: 8),
                  getSpan(
                    controller.state.likeCount == 0
                        ? '喜欢'
                        : '${controller.state.likeCount}',
                  )
                ],
              ),
            ),
          ],
        );
      });
}