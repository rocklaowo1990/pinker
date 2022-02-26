import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/comments_view/comment_item/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getCommentList(
  Rx<CommentsListEntities> commentList,
  int index, {
  required int wid,
}) {
  // 初始化
  // 这种结构的只能在这里初始化
  // 在里面初始化需要在控制器里面加入index变量
  final controller = CommentListController();

  return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 9, 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.line))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getNetworkImageBox(
            commentList.value.list[index].author.avatar,
            shape: BoxShape.circle,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 16),
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
                      onPressed: () {
                        controller.handleReply(commentList, index);
                      },
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
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Column(
              children: [
                LikeButton(
                  onTap: (bool isLike) async {
                    ResponseEntity responseEntity = await ContentApi.like(
                      wid: wid,
                      cid: commentList.value.list[index].cid,
                      type: 2,
                      isLike: commentList.value.list[index].isLike =
                          commentList.value.list[index].isLike == 0 ? 1 : 0,
                    );
                    if (responseEntity.code == 200) {
                      commentList.update((val) {
                        commentList.value.list[index].likeCount +=
                            commentList.value.list[index].isLike == 0 ? -1 : 1;
                      });

                      return commentList.value.list[index].isLike == 0
                          ? false
                          : true;
                    } else {
                      return !isLike;
                    }
                  },
                  size: 18,
                  isLiked:
                      commentList.value.list[index].isLike == 0 ? false : true,
                  likeCount: commentList.value.list[index].likeCount,
                  likeBuilder: (bool isLiked) {
                    return isLiked
                        ? SvgPicture.asset(
                            'assets/svg/icon_like_press.svg',
                            color: AppColors.errro,
                          )
                        : SvgPicture.asset(
                            'assets/svg/icon_like.svg',
                            color: AppColors.secondIcon,
                          );
                  },
                  countBuilder: (int? count, bool isLiked, String text) {
                    return const SizedBox();
                  },
                  likeCountAnimationType:
                      commentList.value.list[index].likeCount < 1000
                          ? LikeCountAnimationType.part
                          : LikeCountAnimationType.none,
                ),
                const SizedBox(height: 8),
                Obx(() => commentList.value.list[index].likeCount == 0
                    ? getSpan('喜欢 ', color: AppColors.secondText)
                    : getSpan('${commentList.value.list[index].likeCount}')),
              ],
            ),
          ),

          // getButton(
          //   width: 60,
          //   background: Colors.transparent,
          //   overlayColor: Colors.transparent,
          //   onPressed: () {},
          //   child: Column(
          //     children: [
          //       Obx(() => commentList.value.list[index].isLike == 0
          //           ? SvgPicture.asset(
          //               'assets/svg/icon_like.svg',
          //               height: 9,
          //             )
          //           : SvgPicture.asset(
          //               'assets/svg/icon_like_press.svg',
          //               height: 9,
          //             )),
          //       const SizedBox(height: 4),
          //       Obx(() => commentList.value.list[index].likeCount == 0
          //           ? getSpan('喜欢')
          //           : getSpan('${commentList.value.list[index].likeCount}')),
          //     ],
          //   ),
          // ),
        ],
      ));
}
