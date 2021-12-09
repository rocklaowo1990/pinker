import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/content/library.dart';

import 'package:pinker/widgets/widgets.dart';

Widget content(
  ListElement item,
) {
  return GetBuilder<ContentBoxController>(
    init: ContentBoxController(),
    builder: (controller) {
      // 推文的作者信息
      Widget author = getUserList(
        border: const Border.fromBorderSide(BorderSide.none),
        avatar: item.author.avatar,
        userName: item.author.userName,
        nickName: item.author.nickName,
        padding: EdgeInsets.fromLTRB(9.w, 10.w, 0, 0),
        button: getButton(
          width: 26.w,
          height: 26.w,
          background: Colors.transparent,
          onPressed: () {},
          child: const Icon(
            Icons.more_horiz,
            color: AppColors.mainIcon,
          ),
        ),
      );

      // 推文的内容
      Widget workContent = SizedBox(
        width: double.infinity,
        child: getSpan(
          item.works.content,
          textAlign: TextAlign.start,
        ),
      );

      /// 图像展示
      Widget image(String url) {
        return getButton(
          radius: BorderRadius.circular(4.w),
          child: Container(
            width: double.infinity,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.w)),
              image:
                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            ),
          ),
          onPressed: () {
            controller.handleOpenImage(item);
          },
        );
      }

      // 资源区内容
      Widget media = item.works.pics != null
          ? Row(
              children: [
                Expanded(
                    child:
                        image(serverApiUrl + serverPort + item.works.pics![0])),
                SizedBox(width: 4.w),
                Expanded(
                    child: item.works.pics!.length > 1
                        ? image(serverApiUrl + serverPort + item.works.pics![1])
                        : Container()),
                SizedBox(width: 4.w),
                Expanded(
                    child: item.works.pics!.length > 2
                        ? image(serverApiUrl + serverPort + item.works.pics![2])
                        : Container()),
              ],
            )
          : item.works.video != null && item.works.video!.previewsUrls != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: image(serverApiUrl +
                                serverPort +
                                item.works.video!.previewsUrls![0])),
                        SizedBox(width: 4.w),
                        Expanded(
                            child: item.works.video!.previewsUrls!.length > 1
                                ? image(serverApiUrl +
                                    serverPort +
                                    item.works.video!.previewsUrls![1])
                                : Container()),
                        SizedBox(width: 4.w),
                        Expanded(
                            child: item.works.video!.previewsUrls!.length > 2
                                ? image(serverApiUrl +
                                    serverPort +
                                    item.works.video!.previewsUrls![2])
                                : Container()),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.w)),
                            image: DecorationImage(
                                image: NetworkImage(serverApiUrl +
                                    serverPort +
                                    item.works.video!.snapshotUrl!),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.w)),
                            color: Colors.black54,
                          ),
                          child: Center(
                            child: getButton(
                                onPressed: () {
                                  controller.handleOpenVideo(
                                      item.works.video!.url!,
                                      item.works.video!.snapshotUrl!);
                                },
                                width: 26.w,
                                height: 26.w,
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 20.w,
                                  color: AppColors.mainIcon,
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Container();
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

      Widget contentInfo = Row(
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

      // body
      return Container(
        color: AppColors.secondBacground,
        child: Column(
          children: [
            author,
            Padding(
              padding: EdgeInsets.fromLTRB(9.w, 8.h, 9.w, 0),
              child: Column(
                children: [
                  if (item.works.content != null &&
                      item.works.content!.isNotEmpty)
                    workContent,
                  if (item.works.pics != null || item.works.video!.url != null)
                    SizedBox(height: 8.h),
                  if (item.works.pics != null || item.works.video!.url != null)
                    media,
                ],
              ),
            ),
            contentInfo,
            Container(height: 1, width: double.infinity, color: AppColors.line),
          ],
        ),
      );
    },
  );
}
