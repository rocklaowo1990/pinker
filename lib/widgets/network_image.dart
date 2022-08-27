import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

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
  var image = DecorationImage(
    image: NetworkImage(serverMediaUrl + url),
    fit: fit,
  );

  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      shape: shape,
      color: color,
      border: border,
      borderRadius: borderRadius,
      image: url.contains('public') ? image : null,
    ),
    clipBehavior: Clip.antiAlias,
  );
}

ImageProvider getNetworkImageProvider(String url) {
  return CachedNetworkImageProvider(
    serverMediaUrl + url,
  );
}
