import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';

import 'package:pinker/values/values.dart';

import 'package:pinker/widgets/widgets.dart';

Widget contentList(ListElement item) {
  final ContentBoxController controller = ContentBoxController();

  controller.initState(item);

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

  /// 推文的内容
  /// 内容因为也是分成了很多情况，所以封装了一个方法
  /// 用来实现不同的情况
  Widget _workContent(VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        child: getSpan(
          item.works.content,
          textAlign: TextAlign.start,
        ),
        onTap: onTap,
      ),
    );
  }

  /// 图像展示
  Widget _image(String url, int index) {
    return getButton(
      background: AppColors.mainBacground,
      borderRadius: BorderRadius.all(Radius.circular(4.w)),
      child: getImageBox(
        url,
        height: 60.h,
        width: double.infinity,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(4.w),
        ),
      ),
      onPressed: () {
        controller.handleOpenImage(item, index);
      },
    );
  }

  /// 图片上展示的数字
  /// 三个图片哪里有
  /// 购买区域哪里也有
  Widget _imageCount(String count) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.w),
        color: AppColors.mainBacground50,
      ),
      child: getSpan(count),
    );
  }

  /// 这里是一排三个的图片，需要传入图片的数组
  Widget _imageBox(List<String> images) {
    return Row(
      children: [
        Expanded(
            child: images.isNotEmpty ? _image(images[0], 0) : const SizedBox()),
        SizedBox(width: 4.w),
        Expanded(
            child: images.length > 1 ? _image(images[1], 1) : const SizedBox()),
        SizedBox(width: 4.w),
        Expanded(
            child: images.length > 2
                ? Stack(
                    children: [
                      _image(images[2], 2),
                      Obx(() =>
                          controller.state.canSee != 0 && images.length > 3
                              ? Positioned(
                                  child: _imageCount('${images.length - 3}'),
                                  bottom: 8,
                                  right: 8,
                                )
                              : const SizedBox()),
                    ],
                  )
                : const SizedBox()),
      ],
    );
  }

  // 底部哪一条功能按钮的封装方法
  // 留言、喜欢、转发、分享
  // 留言、喜欢、转发、分享 的构造
  Widget contentInfo = getContentButton(controller);

  // 没有购买的时候，预览图下方展示的需要购买的信息
  // 图片购买和视频购买所展示的信息不太一样
  // 需要传入参数进行区分
  // 区分图片和视频的信息，区分好了以后展示
  Widget _payBox(int type) {
    late Widget mediaType;
    late String url;
    late String mediaInfo;
    late Widget price;
    if (type == 1) {
      url = item.works.pics[0];
      mediaType = _imageCount('${item.works.pics.length - 3}');
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
      mediaInfo = '视频： ${item.works.video.duration} 分钟';
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
      onPressed: controller.handlePay,
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

  // 资源区
  // 1、分成可观看和不可观看
  // 2、分成视频和图片
  // 应该先判断是视频和图片，再来判断是否可观看
  // 资源区内容组装，先看是什么类型，再来看是否可观看
  // 根据不同的类型来确认不同的显示
  // 另外不可观看到观看是有状态的，购买后就会变成可观看了，这里需要注意
  // 所以需要一个状态管理器
  // 付费后获得新的状态数据，更新数据再来更新显示状态
  Widget _showMedia() {
    if (item.works.pics.isNotEmpty) {
      return Obx(() => controller.state.canSee != 0
          ? Column(
              children: [
                item.works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(() {
                          controller.handleOpenImage(item, 0);
                        }),
                      )
                    : SizedBox(height: 8.h),
                _imageBox(item.works.pics),
              ],
            )
          : Column(
              children: [
                item.works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(() {
                          controller.handleOpenImage(item, 0);
                        }),
                      )
                    : SizedBox(height: 8.h),
                _imageBox(item.works.pics),
                SizedBox(height: 8.h),
                _payBox(1),
              ],
            ));
    } else if (item.works.video.url.isNotEmpty) {
      return Obx(() => controller.state.canSee != 0
          ? Column(
              children: [
                item.works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(() {
                          controller.handleOpenVideo(
                              item, item.works.video.url);
                        }),
                      )
                    : SizedBox(height: 8.h),
                Stack(
                  children: [
                    getImageBox(item.works.video.snapshotUrl,
                        width: double.infinity,
                        height: 128.h,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(4.w))),
                    getButton(
                      onPressed: () {
                        controller.handleOpenVideo(item, item.works.video.url);
                      },
                      borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      height: 128.h,
                      background: Colors.black54,
                      child: Center(
                        child: Container(
                          width: 26.w,
                          height: 26.w,
                          child: Icon(
                            Icons.play_arrow,
                            size: 20.w,
                            color: AppColors.mainIcon,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor,
                            border: Border.all(
                                color: AppColors.mainIcon, width: 1.w),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                item.works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(() {
                          controller.handleOpenImage(item, 0);
                        }),
                      )
                    : SizedBox(height: 8.h),
                _imageBox(item.works.video.previewsUrls),
                SizedBox(height: 8.h),
                _payBox(2),
              ],
            ));
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: _workContent(() {
          controller.handleOpenContent(item);
        }),
      );
    }
  }

  Widget mediaBox = _showMedia();

  // 这里是推文的整理布局
  // 布局也是包含头像、文字（可有可无）、媒体（可有可无）
  Widget body = Column(
    children: [
      author, // 头像部分
      Padding(
        padding: EdgeInsets.only(left: 9.w, right: 9.w),
        child: mediaBox,
      ), // 媒体部分，包含文字、图片和视频
      contentInfo, // 底部的留言、喜欢、转发、分享
      Container(height: 1, width: double.infinity, color: AppColors.line),
    ],
  );

  // body：也就是整个推文的组装了，包含在一个小部件里
  return Container(
    color: AppColors.secondBacground,
    child: body,
  );
}
