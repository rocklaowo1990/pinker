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
    url,
    width: width,
    height: height,
    fit: fit,
    cache: true,
    border: border,
    shape: shape,
    borderRadius: borderRadius,
    mode: mode,
  );
}
