import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/utils/validator.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 推文列表里的头像部分
/// 这里分开也是因为不仅一个地方调用该事件
/// 本部分也包含点击事件
Widget getContentAvatar(ListElement item) {
  void _onPressed() {}

  return getUserAvatar(
    item.author.avatar,
    item.author.nickName,
    '${item.author.userName} · ${getDateTime(item.createDate)}',
    onPressed: _onPressed,
  );
}

/// 这是推文里的更多按钮
Widget getContentMore(
  ListElement item, {
  Color background = Colors.transparent,
  double? width,
  double? height,
}) {
  void _onPressed() {
    print(item.author.userName);
  }

  return Center(
    child: getButton(
      width: width ?? 26.w,
      height: height ?? 26.w,
      background: background,
      onPressed: _onPressed,
      child: const Icon(
        Icons.more_horiz,
        color: AppColors.mainIcon,
      ),
    ),
  );
}
