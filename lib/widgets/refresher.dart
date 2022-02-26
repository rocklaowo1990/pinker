import 'package:flutter/material.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 上下刷新组件
/// 可以控制是否需要上拉
/// 下拉刷新是一定有的
Widget getRefresher({
  required RefreshController controller,
  required Widget child,
  bool isFooter = true,
  VoidCallback? onRefresh,
  VoidCallback? onLoading,
  ScrollController? scrollController,
  Widget? header,
}) {
  return SmartRefresher(
    scrollController: scrollController,
    controller: controller,
    enablePullUp: isFooter,
    child: child,
    header: header ??
        WaterDropHeader(
          complete: getSpanSecond('刷新成功'),
          idleIcon:
              const Icon(Icons.autorenew, size: 16, color: AppColors.mainIcon),
          waterDropColor: AppColors.secondText,
          refresh: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  backgroundColor: AppColors.mainIcon,
                  color: AppColors.mainColor,
                  strokeWidth: 1.5)),
        ),
    footer: isFooter
        ? CustomFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = getSpanSecond("加载完成");
              } else if (mode == LoadStatus.loading) {
                body = const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                        backgroundColor: AppColors.mainIcon,
                        color: AppColors.mainColor,
                        strokeWidth: 1.5));
              } else if (mode == LoadStatus.failed) {
                body = getSpanSecond("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = getSpanSecond("释放刷新");
              } else {
                body = getSpanSecond("没有更多数据了!");
              }
              return Center(
                child: Padding(
                  child: body,
                  padding: const EdgeInsets.only(top: 20),
                ),
              );
            },
          )
        : null,
    onRefresh: onRefresh,
    onLoading: onLoading,
  );
}
