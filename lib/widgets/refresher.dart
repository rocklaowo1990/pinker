import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
          complete: getSpan('刷新成功', color: AppColors.secondText),
          idleIcon:
              const Icon(Icons.autorenew, size: 20, color: AppColors.mainIcon),
          waterDropColor: AppColors.secondText,
          refresh: SizedBox(
              width: 9.w,
              height: 9.w,
              child: CircularProgressIndicator(
                  backgroundColor: AppColors.mainIcon,
                  color: AppColors.mainColor,
                  strokeWidth: 1.w)),
        ),
    footer: isFooter
        ? CustomFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = getSpan(
                  "加载完成",
                  color: AppColors.secondText,
                );
              } else if (mode == LoadStatus.loading) {
                body = SizedBox(
                    width: 9.w,
                    height: 9.w,
                    child: CircularProgressIndicator(
                        backgroundColor: AppColors.mainIcon,
                        color: AppColors.mainColor,
                        strokeWidth: 1.w));
              } else if (mode == LoadStatus.failed) {
                body = getSpan(
                  "加载失败！点击重试！",
                  color: AppColors.secondText,
                );
              } else if (mode == LoadStatus.canLoading) {
                body = getSpan(
                  "释放刷新",
                  color: AppColors.secondText,
                );
              } else {
                body = getSpan(
                  "没有更多数据了!",
                  color: AppColors.secondText,
                );
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
