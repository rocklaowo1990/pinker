import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/pages/dynamic/dynamic.dart';
import 'package:pinker/utils/utils.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getContentListView(Rx<ContentListEntities> contentList, int index) {
  // 推文的作者信息
  Widget author = Padding(
    padding: EdgeInsets.fromLTRB(9.w, 10.w, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: getContentAvatar(contentList, index)),
        getContentMore(contentList, index),
      ],
    ),
  );

  /// 推文的内容
  /// 内容因为也是分成了很多情况，所以封装了一个方法
  /// 用来实现不同的情况
  Widget _workContent() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        child: getSpan(
          contentList.value.list[index].works.content,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  /// 图像展示
  Widget _image(String url, int imagetIndex) {
    return getButton(
      background: AppColors.mainBacground,
      borderRadius: BorderRadius.all(Radius.circular(4.w)),
      child: getNetworkImageBox(
        url,
        height: 60.h,
        width: double.infinity,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(4.w),
        ),
      ),
      onPressed: () {
        getMediaView(contentList, index, imagetIndex: imagetIndex);
      },
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
                      Obx(() => contentList.value.list[index].canSee != 0 &&
                              images.length > 3
                          ? Positioned(
                              child: getImageCount('+${images.length - 3}'),
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
  Widget contentInfo = getContentButton(contentList, index);

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
    if (contentList.value.list[index].works.pics.isNotEmpty) {
      return Obx(() => contentList.value.list[index].canSee != 0
          ? Column(
              children: [
                contentList.value.list[index].works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(),
                      )
                    : SizedBox(height: 8.h),
                _imageBox(contentList.value.list[index].works.pics),
              ],
            )
          : Column(
              children: [
                contentList.value.list[index].works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(),
                      )
                    : SizedBox(height: 8.h),
                _imageBox(contentList.value.list[index].works.pics),
                SizedBox(height: 8.h),
                getContentPayBox(contentList, index),
              ],
            ));
    } else if (contentList.value.list[index].works.video.url.isNotEmpty) {
      return Obx(() => contentList.value.list[index].canSee != 0
          ? Column(
              children: [
                contentList.value.list[index].works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(),
                      )
                    : SizedBox(height: 8.h),
                Stack(
                  children: [
                    getNetworkImageBox(
                        contentList.value.list[index].works.video.snapshotUrl,
                        width: double.infinity,
                        height: 128.h,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(4.w))),
                    getButton(
                      onPressed: () {
                        getMediaView(contentList, index);
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
                    Positioned(
                      child: getImageCount(getDuration(
                          contentList.value.list[index].works.video.duration)),
                      bottom: 8,
                      left: 8,
                    )
                  ],
                ),
              ],
            )
          : Column(
              children: [
                contentList.value.list[index].works.content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: _workContent(),
                      )
                    : SizedBox(height: 8.h),
                _imageBox(
                    contentList.value.list[index].works.video.previewsUrls),
                SizedBox(height: 8.h),
                getContentPayBox(contentList, index),
              ],
            ));
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: _workContent(),
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
    child: contentList.value.list[index].works.payPermission.isLimitFree == 0
        ? body
        : Stack(
            children: [
              body,
              Image.asset(
                'assets/images/xian.png',
                height: 24.h,
              )
            ],
          ),
  );
}
