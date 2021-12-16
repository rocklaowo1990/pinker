import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinker/values/values.dart';

Widget getImageBox(
  String url, {
  double? width,
  double? height,
  BoxShape? shape,
  Color color = AppColors.mainBacground,
  BoxFit fit = BoxFit.cover,
  BoxBorder? border,
  BorderRadius? borderRadius,
  ExtendedImageMode mode = ExtendedImageMode.none,
}) {
  return ExtendedImage.network(
    serverApiUrl + serverPort + url,
    width: width,
    height: height,
    cancelToken: CancellationToken(),
    fit: fit,
    cache: true,
    retries: 1,
    timeLimit: const Duration(seconds: 3),
    border: border,
    shape: shape,
    borderRadius: borderRadius,
    mode: mode,
    cacheMaxAge: const Duration(days: 5),
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
}
