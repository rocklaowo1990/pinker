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
Widget getContentButton(
  Rx<ContentListEntities> contentList,
  int index, {
  String storageKey = storageHomeContentListKey,
  int? cid,
}) {
  int _likeCount = contentList.value.list[index].likeCount;
  int _forwardCount = contentList.value.list[index].forwardCount;
  int _commentCount = contentList.value.list[index].commentCount;

  bool _isLike = contentList.value.list[index].isLike == 0 ? false : true;
  bool _isForward = contentList.value.list[index].isForward == 0 ? false : true;

  Future<bool> _onComment(bool? isComment) async {
    getCommentsView(contentList, index, storageKey: storageKey);
    return Future<bool>.delayed(const Duration(milliseconds: 50), () {
      return false;
    });
  }

  Future<bool> _onLike(bool isLike) async {
    Map<String, dynamic> data = {
      'wid': contentList.value.list[index].wid,
      if (cid != null) 'cid': cid,
      'type': cid == null ? 1 : 2,
      'isLike': contentList.value.list[index].isLike =
          contentList.value.list[index].isLike == 0 ? 1 : 0,
    };

    ResponseEntity responseEntity = await ContentApi.like(data);
    if (responseEntity.code == 200) {
      contentList.value.list[index].likeCount +=
          contentList.value.list[index].isLike == 0 ? -1 : 1;
      await StorageUtil().setJSON(storageKey, contentList.value);
      return contentList.value.list[index].isLike == 0 ? false : true;
    } else {
      return !isLike;
    }
  }

  Future<bool> _onForward(bool isForward) async {
    return Future<bool>.delayed(const Duration(milliseconds: 50), () {
      contentList.value.list[index].isForward =
          contentList.value.list[index].isForward == 0 ? 1 : 0;
      return contentList.value.list[index].isForward == 0 ? false : true;
    });
  }

  return Row(
    children: [
      Row(
        children: [
          SizedBox(width: 9.w),
          LikeButton(
            size: 20.0,
            likeCountPadding: EdgeInsets.only(left: 3.w),
            likeCount: contentList.value.list[index].commentCount,
            likeBuilder: (bool isComment) {
              return SvgPicture.asset(
                'assets/svg/icon_reply.svg',
              );
            },
            countBuilder: (int? count, bool isLiked, String text) {
              return count == 0
                  ? getSpan('评论', color: AppColors.secondText)
                  : getSpan(count! >= 1000
                      ? (count / 1000.0).toStringAsFixed(1) + 'k'
                      : text);
            },
            onTap: _onComment,
          ),
          SizedBox(width: 15.w),
          LikeButton(
            onTap: _onLike,
            size: 18.0,
            isLiked: _isLike,
            likeCountPadding: EdgeInsets.only(left: 3.w),
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
          SizedBox(width: 15.w),
          LikeButton(
            size: 18.0,
            likeCountPadding: EdgeInsets.only(left: 3.w),
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
          height: 10.w,
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
    padding: padding ?? EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
    height: 24.w + 15,
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
