// 底部哪一条功能按钮的封装方法
// 留言、喜欢、转发、分享
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

Widget _contentButton({
  required Widget icon,
  String? data,
  VoidCallback? onPressed,
  Color color = AppColors.secondText,
}) {
  return getButton(
    padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
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

// 留言、喜欢、转发、分享 的构造
Widget getContentButton(ContentBoxController contentBoxController) {
  void _onLike() {
    contentBoxController.state.isLike =
        contentBoxController.state.isLike == 0 ? 1 : 0;
    contentBoxController.state.isLike == 0
        ? contentBoxController.state.likeCount--
        : contentBoxController.state.likeCount++;
  }

  void _onForward() {
    contentBoxController.state.isForward =
        contentBoxController.state.isForward == 0 ? 1 : 0;
    contentBoxController.state.isForward == 0
        ? contentBoxController.state.forwardCount--
        : contentBoxController.state.forwardCount++;
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
                data: contentBoxController.state.commentCount == 0
                    ? '写评论'
                    : '${contentBoxController.state.commentCount}',
              )),
          Obx(() => _contentButton(
                icon: contentBoxController.state.isLike == 0
                    ? SvgPicture.asset(
                        'assets/svg/icon_like.svg',
                        height: 9.w,
                      )
                    : SvgPicture.asset(
                        'assets/svg/icon_like_press.svg',
                        height: 9.w,
                      ),
                data: contentBoxController.state.likeCount == 0
                    ? '喜欢'
                    : '${contentBoxController.state.likeCount}',
                onPressed: _onLike,
                color: contentBoxController.state.isLike == 0
                    ? AppColors.secondText
                    : AppColors.errro,
              )),
          Obx(() => _contentButton(
                icon: SvgPicture.asset(
                  'assets/svg/icon_forward.svg',
                  height: 10.w,
                  color: contentBoxController.state.isForward == 0
                      ? null
                      : Colors.green,
                ),
                data: contentBoxController.state.forwardCount == 0
                    ? '转发'
                    : '${contentBoxController.state.forwardCount}',
                color: contentBoxController.state.isForward == 0
                    ? AppColors.secondText
                    : Colors.green,
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
