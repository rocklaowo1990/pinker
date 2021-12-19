// 底部哪一条功能按钮的封装方法
// 留言、喜欢、转发、分享
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/widgets/widgets.dart';

Widget _contentButton({
  required Widget icon,
  int? data,
  VoidCallback? onPressed,
}) {
  return getButton(
    padding: EdgeInsets.fromLTRB(9.w, 10.w, 9.w, 10.w),
    background: Colors.transparent,
    overlayColor: Colors.transparent,
    onPressed: onPressed,
    child: Row(
      children: [
        icon,
        if (data != null) SizedBox(width: 4.w),
        if (data != null)
          getSpan(
            '$data',
          ),
      ],
    ),
  );
}

// 留言、喜欢、转发、分享 的构造
Widget contentButton(ListElement item) {
  return Row(
    children: [
      Row(
        children: [
          _contentButton(
            icon: SvgPicture.asset(
              'assets/svg/icon_reply.svg',
              height: 10.w,
            ),
            data: item.commentCount,
          ),
          _contentButton(
            icon: SvgPicture.asset(
              'assets/svg/icon_like.svg',
              height: 9.w,
            ),
            data: item.likeCount,
          ),
          _contentButton(
            icon: SvgPicture.asset(
              'assets/svg/icon_forward.svg',
              height: 10.w,
            ),
            data: item.forwardCount,
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
