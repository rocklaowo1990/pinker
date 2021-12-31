import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getCommentList(
  Rx<CommentsListEntities> commentList,
  int index, {
  Rx<ContentListEntities>? contentList,
  int? contentListIndex,
  int? contentListType,
}) {
  // 初始化
  // 这种结构的只能在这里初始化
  // 在里面初始化需要在控制器里面加入index变量

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getImageBox(
        commentList.value.list[index].author.avatar,
        shape: BoxShape.circle,
        width: 50,
      ),
      SizedBox(width: 9.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSpan(commentList.value.list[index].author.nickName),
            Row(
              children: [
                getSpan(
                  commentList.value.list[index].author.userName,
                  color: AppColors.secondText,
                ),
                getButton(
                  child: getSpan('回复'),
                  height: 26,
                  width: 60,
                  background: Colors.transparent,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            commentList.value.list[index].replyUser != null
                ? RichText(
                    text: TextSpan(
                      text:
                          '@${commentList.value.list[index].replyUser!.userName}  ',
                      style: const TextStyle(
                          color: AppColors.mainColor, fontSize: 15),
                      children: [
                        TextSpan(
                          text: commentList.value.list[index].content,
                          style: const TextStyle(
                              color: AppColors.mainText, fontSize: 15),
                        ),
                      ],
                    ),
                  )
                : getSpan(commentList.value.list[index].content),
            const SizedBox(height: 16),
          ],
        ),
      ),
      getButton(
        width: 60,
        background: Colors.transparent,
        overlayColor: Colors.transparent,
        onPressed: () {},
        child: Column(
          children: [
            Obx(() => commentList.value.list[index].isLike == 0
                ? SvgPicture.asset(
                    'assets/svg/icon_like.svg',
                    height: 9.w,
                  )
                : SvgPicture.asset(
                    'assets/svg/icon_like_press.svg',
                    height: 9.w,
                  )),
            const SizedBox(height: 4),
            Obx(() => commentList.value.list[index].likeCount == 0
                ? getSpan('喜欢')
                : getSpan('${commentList.value.list[index].likeCount}')),
          ],
        ),
      ),
    ],
  );
}
