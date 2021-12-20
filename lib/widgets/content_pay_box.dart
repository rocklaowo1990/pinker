import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

// 没有购买的时候，预览图下方展示的需要购买的信息
// 图片购买和视频购买所展示的信息不太一样
// 需要传入参数进行区分
// 区分图片和视频的信息，区分好了以后展示
Widget getContentPayBox(
  ListElement item,
  int type,
  ContentBoxController contentBoxController,
  MediaViewController? mediaViewController,
) {
  late Widget mediaType;
  late String url;
  late String mediaInfo;
  late Widget price;

  void _onPressed() {
    contentBoxController.state.canSee = 1;
    if (mediaViewController != null) {
      if (item.works.video.url.isNotEmpty) {
        mediaViewController.fijkPlayer = FijkPlayer();
        mediaViewController.fijkPlayer!.setDataSource(
            serverApiUrl + serverPort + item.works.video.url,
            autoPlay: true);
      } else {
        for (int i = 4; i < item.works.pics.length; i++) {
          mediaViewController.state.imagesList.add(item.works.pics[i]);
        }
      }
    }
  }

  if (type == 1) {
    url = item.works.pics[0];
    mediaType = getImageCount('${item.works.pics.length - 3}');
    mediaInfo = '图片： ${item.works.pics.length - 3} 张';
  } else {
    url = item.works.video.previewsUrls[0];
    mediaType = Container(
      height: 20.w,
      width: 20.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.mainBacground50,
      ),
      child: Center(
        child: Icon(
          Icons.play_arrow,
          color: AppColors.mainIcon,
          size: 12.w,
        ),
      ),
    );
    mediaInfo = '视频：' + getDuration(item.works.video.duration);
  }

  if (item.works.payPermission.type == 2) {
    price = getSpan(
      '需订阅',
      color: AppColors.thirdText,
      fontSize: 17,
    );
  } else {
    if (item.works.payPermission.type != 0) {
      price = Row(
        children: [
          SvgPicture.asset(
            'assets/svg/icon_diamond.svg',
            height: 13,
          ),
          const SizedBox(width: 5),
          getSpan(
            '${item.works.payPermission.price}',
            color: AppColors.thirdText,
          ),
        ],
      );
    }
  }
  return getButton(
    onPressed: _onPressed,
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(5.w, 5.w, 8.w, 5.w),
    background: AppColors.inputFiled,
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
