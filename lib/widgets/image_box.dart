import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinker/values/values.dart';

/// 这个方法是所有网络图片的容器
/// networ 都调用这个方法
/// 这个方法可以用来缓存图片
Widget getImageBox(
  String url, {
  double? width,
  double? height,
  BoxShape shape = BoxShape.rectangle,
  Color color = AppColors.mainBacground,
  BoxFit fit = BoxFit.fitWidth,
  BoxBorder? border,
  BorderRadius? borderRadius,
  ExtendedImageMode mode = ExtendedImageMode.none,
}) {
  return ExtendedImage.network(
    serverApiUrl + serverPort + url,
    width: width,
    height: height,
    fit: fit,
    cache: true,
    retries: 1,
    timeLimit: const Duration(seconds: 3),
    border: border,
    shape: shape,
    borderRadius: borderRadius,
    mode: mode,
    initGestureConfigHandler: mode == ExtendedImageMode.gesture
        ? (state) {
            return GestureConfig(
              minScale: 1.0,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: false,
              initialAlignment: InitialAlignment.center,
              cacheGesture: false,
            );
          }
        : null,
  );

  // return Container(
  //   width: width,
  //   height: height,
  //   decoration: BoxDecoration(
  //       border: border,
  //       borderRadius: borderRadius,
  //       color: color,
  //       shape: shape,
  //       image: DecorationImage(
  //         image: NetworkImage(
  //           serverApiUrl + serverPort + url,
  //         ),
  //         fit: fit,
  //       )),
  // );
}
