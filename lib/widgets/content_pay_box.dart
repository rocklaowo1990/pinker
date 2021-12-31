import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/dynamic.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 图片上展示的数字
/// 三个图片哪里有
/// 购买区域哪里也有
Widget getImageCount(String count) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.w),
      color: AppColors.mainBacground50,
    ),
    child: getSpan(count),
  );
}

/// 没有购买的时候，预览图下方展示的需要购买的信息
/// 图片购买和视频购买所展示的信息不太一样
/// 需要传入参数进行区分
/// 区分图片和视频的信息，区分好了以后展示
Widget getContentPayBox(Rx<ContentListEntities> contentList, int index) {
  late Widget mediaType;
  late String url;
  late String mediaInfo;
  late Widget price;

  void _onPressed() {
    contentList.value.list[index].canSee = 1;
  }

  url = contentList.value.list[index].works.pics.isNotEmpty
      ? contentList.value.list[index].works.pics[0]
      : contentList.value.list[index].works.video.previewsUrls[0];
  mediaType = getImageCount('000');
  mediaInfo = '图片： 0 张';
  price = getSpan('text');

  return getButton(
    onPressed: _onPressed,
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(5.w, 5.w, 8.w, 5.w),
    background: AppColors.line,
    borderRadius: BorderRadius.all(Radius.circular(4.w)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Stack(
                children: [
                  getImageBox(url,
                      width: 32.h,
                      height: 32.h,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  SizedBox(
                    height: 32.h,
                    width: 32.h,
                    child: Center(
                      child: mediaType,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      getSpan(
                        '付费资源：',
                        color: AppColors.thirdText,
                      ),
                      price,
                    ],
                  ),
                  const SizedBox(height: 2),
                  getSpan(mediaInfo, color: AppColors.secondText),
                ],
              )
            ],
          ),
        ),
        Container(
          child: getSpan('查看'),
          padding: EdgeInsets.fromLTRB(12.w, 4.w, 12.w, 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500.w),
            color: AppColors.mainColor,
          ),
        ),
      ],
    ),
  );
}
