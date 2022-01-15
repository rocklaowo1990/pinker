import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pinker/values/values.dart';

/// 这个方法是所有网络图片的容器
/// networ 都调用这个方法
/// 这个方法可以用来缓存图片
Widget getNetworkImageBox(
  String url, {
  double? width,
  double? height,
  BoxShape shape = BoxShape.rectangle,
  Color color = AppColors.mainBacground,
  BoxFit fit = BoxFit.cover,
  BoxBorder? border,
  BorderRadius? borderRadius,
}) {
  return CachedNetworkImage(
    imageUrl: serverApiUrl + serverPort + url,
    imageBuilder: (context, image) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
        color: color,
        shape: shape,
        image: DecorationImage(image: image, fit: fit),
      ),
    ),
    placeholder: (context, url) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
        color: color,
        shape: shape,
      ),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 1.w,
          ),
        ),
      ),
    ),
    errorWidget: (context, url, error) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
        color: color,
        shape: shape,
      ),
      child: const Center(
        child:
            SizedBox(width: 20, height: 20, child: Icon(Icons.error, size: 20)),
      ),
    ),
  );
}

ImageProvider getNetworkImageProvider(String url) {
  return CachedNetworkImageProvider(
    serverApiUrl + serverPort + url,
  );
}
