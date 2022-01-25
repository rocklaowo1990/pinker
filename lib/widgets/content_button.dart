import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/comments_view/view.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:like_button/like_button.dart';

import 'package:pinker/widgets/widgets.dart';

/// 底部哪一条功能按钮的封装方法
/// 留言、喜欢、转发、分享
/// 留言、喜欢、转发、分享 的构造
Widget getContentButton(Rx<ContentListEntities> contentList, int index) {
  int _likeCount = contentList.value.list[index].likeCount;
  int _forwardCount = contentList.value.list[index].forwardCount;
  int _commentCount = contentList.value.list[index].commentCount;

  bool _isLike = contentList.value.list[index].isLike == 0 ? false : true;
  bool _isForward = contentList.value.list[index].isForward == 0 ? false : true;

  Future<bool> _onComment(bool? isComment) async {
    getCommentsView(contentList, index);
    return Future<bool>.delayed(const Duration(milliseconds: 50), () {
      return false;
    });
  }

  Future<bool> _onLike(bool isLike) async {
    ResponseEntity responseEntity = await ContentApi.like(
      wid: contentList.value.list[index].wid,
      type: 1,
      isLike: contentList.value.list[index].isLike =
          contentList.value.list[index].isLike == 0 ? 1 : 0,
    );
    if (responseEntity.code == 200) {
      contentList.value.list[index].likeCount +=
          contentList.value.list[index].isLike == 0 ? -1 : 1;

      getContentOnly(wid: contentList.value.list[index].wid);

      return contentList.value.list[index].isLike == 0 ? false : true;
    } else {
      getSnackTop(responseEntity.msg);
      return !isLike;
    }
  }

  Future<bool> _onForward(bool isForward) async {
    ResponseEntity responseEntity = await ContentApi.forward(
      wid: contentList.value.list[index].wid,
      isForward: contentList.value.list[index].isForward =
          contentList.value.list[index].isForward == 0 ? 1 : 0,
    );
    if (responseEntity.code == 200) {
      contentList.value.list[index].forwardCount +=
          contentList.value.list[index].isForward == 0 ? -1 : 1;

      getContentOnly(wid: contentList.value.list[index].wid);

      return contentList.value.list[index].isForward == 0 ? false : true;
    } else {
      return !isForward;
    }
  }

  return Row(
    children: [
      Row(
        children: [
          SizedBox(width: 16.w),
          LikeButton(
            size: 20.sp,
            likeCountPadding: EdgeInsets.only(left: 8.w),
            likeCount: _commentCount,
            likeBuilder: (bool isComment) {
              return SvgPicture.asset(
                'assets/svg/icon_reply.svg',
              );
            },
            countBuilder: (int? count, bool isLiked, String text) {
              return Obx(() => getSpan(
                  contentList.value.list[index].commentCount == 0
                      ? '评论'
                      : contentList.value.list[index].commentCount >= 1000
                          ? (contentList.value.list[index].commentCount /
                                      1000.0)
                                  .toStringAsFixed(1) +
                              'k'
                          : '${contentList.value.list[index].commentCount}',
                  color: contentList.value.list[index].commentCount == 0
                      ? AppColors.secondText
                      : null));
            },
            onTap: _onComment,
          ),
          SizedBox(width: 30.w),
          LikeButton(
            onTap: _onLike,
            size: 18.sp,
            isLiked: _isLike,
            likeCountPadding: EdgeInsets.only(left: 8.w),
            likeCount: _likeCount,
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
              return count == 0
                  ? getSpan('喜欢', color: AppColors.secondText)
                  : getSpan(
                      count! >= 1000
                          ? (count / 1000.0).toStringAsFixed(1) + 'k'
                          : text,
                      color: isLiked ? AppColors.errro : AppColors.secondText);
            },
            likeCountAnimationType: _likeCount < 1000
                ? LikeCountAnimationType.part
                : LikeCountAnimationType.none,
          ),
          SizedBox(width: 30.w),
          LikeButton(
            onTap: _onForward,
            size: 18.sp,
            likeCountPadding: EdgeInsets.only(left: 8.w),
            bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xFF009688),
                dotSecondaryColor: Colors.tealAccent,
                dotThirdColor: Color(0xFFA5D6A7),
                dotLastColor: Color(0xFF80CBC4)),
            circleColor:
                const CircleColor(start: Colors.green, end: AppColors.fourText),
            isLiked: _isForward,
            likeCount: _forwardCount,
            likeBuilder: (bool isForward) {
              return isForward
                  ? SvgPicture.asset(
                      'assets/svg/icon_forward_press.svg',
                      color: AppColors.fourText,
                    )
                  : SvgPicture.asset('assets/svg/icon_forward.svg');
            },
            countBuilder: (int? count, bool isForward, String text) {
              return count == 0
                  ? getSpan('转发', color: AppColors.secondText)
                  : getSpan(
                      count! >= 1000
                          ? (count / 1000.0).toStringAsFixed(1) + 'k'
                          : text,
                      color: isForward
                          ? AppColors.fourText
                          : AppColors.secondText);
            },
            likeCountAnimationType: _forwardCount < 1000
                ? LikeCountAnimationType.part
                : LikeCountAnimationType.none,
          ),
        ],
      ),
      const Spacer(),
      _contentButton(
        icon: SvgPicture.asset(
          'assets/svg/icon_share.svg',
          height: 18.w,
        ),
      ),
    ],
  );
}

Widget _contentButton({
  required Widget icon,
  String? data,
  VoidCallback? onPressed,
  Color color = AppColors.secondText,
  EdgeInsetsGeometry? padding,
}) {
  return getButton(
    padding: padding ?? EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
    height: 50.h,
    background: Colors.transparent,
    overlayColor: Colors.transparent,
    onPressed: onPressed,
    child: Row(
      children: [
        icon,
        if (data != null) SizedBox(width: 1.w),
        if (data != null)
          getSpan(
            data,
            color: color,
          ),
      ],
    ),
  );
}
