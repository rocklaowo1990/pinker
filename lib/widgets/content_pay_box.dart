import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/application/library.dart';
import 'package:pinker/pages/dynamic/media_view/library.dart';
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
Widget getContentPayBox(
  Rx<ContentListEntities> contentList,
  int index, {
  MediaViewController? mediaViewController,
}) {
  late Widget mediaType;
  late String url;
  late String mediaInfo;
  late Widget price;

  final ApplicationController applicationController = Get.find();

  void _onPressed() async {
    if (contentList.value.list[index].works.payPermission.type == 1) {
      getSubscribeBox(
          userId: contentList.value.list[index].author.userId,
          userName: contentList.value.list[index].author.userName,
          avatar: contentList.value.list[index].author.avatar,
          reSault: () {
            if (mediaViewController != null) {
              mediaViewController.fijkPlayer = FijkPlayer();

              mediaViewController.fijkPlayer!.setDataSource(
                  serverApiUrl +
                      serverPort +
                      contentList.value.list[index].works.video.url,
                  autoPlay: true);
            }
            contentList.update((val) {
              if (val != null) {
                val.list[index].canSee = 1;
              }
            });
          });
    } else if (contentList.value.list[index].works.payPermission.type == 2 ||
        contentList.value.list[index].works.payPermission.type == 3 ||
        contentList.value.list[index].works.payPermission.type == 4) {
      getContentPaySheet(
        userInfo: applicationController.state.userInfo,
        contentList: contentList,
        index: index,
        reSault: () {
          if (mediaViewController != null) {
            mediaViewController.fijkPlayer = FijkPlayer();

            mediaViewController.fijkPlayer!.setDataSource(
                serverApiUrl +
                    serverPort +
                    contentList.value.list[index].works.video.url,
                autoPlay: true);
          }
          contentList.update((val) {
            if (val != null) {
              val.list[index].canSee = 1;
            }
          });
        },
      );
    }
  }

  if (contentList.value.list[index].works.pics.isNotEmpty) {
    url = contentList.value.list[index].works.pics[0];
    mediaType = getImageCount(
        '+${contentList.value.list[index].works.pics.length - 3}');
    mediaInfo = '图片： ${contentList.value.list[index].works.pics.length - 3} 张';
  } else {
    url = contentList.value.list[index].works.video.previewsUrls[0];
    mediaType = Container(
      width: 18.w,
      height: 18.w,
      child: Icon(
        Icons.play_arrow,
        size: 12.w,
        color: AppColors.mainIcon,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.mainColor,
        border: Border.all(color: AppColors.mainIcon, width: 1.w),
      ),
    );
    var time = getDuration(contentList.value.list[index].works.video.duration);
    mediaInfo = '视频：$time';
  }
  price = contentList.value.list[index].works.payPermission.type == 1
      ? getSpan('需订阅', color: AppColors.thirdText)
      : contentList.value.list[index].works.payPermission.type == 2
          ? getSpan('订阅或付费', color: AppColors.thirdText)
          : contentList.value.list[index].works.payPermission.type == 3 &&
                  contentList.value.list[index].subStatus == 0
              ? getSpan('订阅且付费', color: AppColors.thirdText)
              : Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/icon_diamond.svg',
                      height: 15,
                    ),
                    SizedBox(width: 3.w),
                    getSpan(
                        '${contentList.value.list[index].works.payPermission.price}',
                        color: AppColors.thirdText),
                  ],
                );

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
                  getNetworkImageBox(url,
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
