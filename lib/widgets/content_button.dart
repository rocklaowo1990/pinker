import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/comments_view/view.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

/// 底部哪一条功能按钮的封装方法
/// 留言、喜欢、转发、分享
/// 留言、喜欢、转发、分享 的构造
Widget getContentButton(
  Rx<ContentListEntities> contentList,
  int index, {
  int? type,
}) {
  void _onLike() {
    contentList.value.list[index].isLike =
        contentList.value.list[index].isLike == 0 ? 1 : 0;
    contentList.value.list[index].isLike == 0
        ? contentList.value.list[index].likeCount--
        : contentList.value.list[index].likeCount++;
  }

  void _onForward() {
    contentList.value.list[index].isForward =
        contentList.value.list[index].isForward == 0 ? 1 : 0;
    contentList.value.list[index].isForward == 0
        ? contentList.value.list[index].forwardCount--
        : contentList.value.list[index].forwardCount++;
  }

  void _onComment() {
    getCommentsView(contentList, index, type: type);
  }

  return Row(
    children: [
      Row(
        children: [
          Obx(() => _contentButton(
                icon: SvgPicture.asset(
                  'assets/svg/icon_reply.svg',
                  height: 10.w,
                ),
                onPressed: _onComment,
                data: contentList.value.list[index].commentCount == 0
                    ? '写评论'
                    : '${contentList.value.list[index].commentCount}',
              )),
          Obx(() => _contentButton(
                icon: contentList.value.list[index].isLike == 0
                    ? SvgPicture.asset(
                        'assets/svg/icon_like.svg',
                        height: 9.w,
                      )
                    : SvgPicture.asset(
                        'assets/svg/icon_like_press.svg',
                        height: 9.w,
                      ),
                data: contentList.value.list[index].likeCount == 0
                    ? '喜欢'
                    : '${contentList.value.list[index].likeCount}',
                onPressed: _onLike,
                color: contentList.value.list[index].isLike == 0
                    ? AppColors.secondText
                    : AppColors.errro,
              )),
          Obx(() => _contentButton(
                icon: contentList.value.list[index].isForward == 0
                    ? SvgPicture.asset(
                        'assets/svg/icon_forward.svg',
                        height: 10.w,
                      )
                    : SvgPicture.asset(
                        'assets/svg/icon_forward_press.svg',
                        height: 10.w,
                        color: AppColors.fourText,
                      ),
                data: contentList.value.list[index].forwardCount == 0
                    ? '转发'
                    : '${contentList.value.list[index].forwardCount}',
                color: contentList.value.list[index].isForward == 0
                    ? AppColors.secondText
                    : AppColors.fourText,
                onPressed: _onForward,
              )),
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
        if (data != null) SizedBox(width: 4.w),
        if (data != null)
          getSpan(
            data,
            color: color,
          ),
      ],
    ),
  );
}
