import 'package:get/get.dart';

class MediaViewState {
  /// 透明度监听
  final RxInt opacityListenRx = 0.obs;
  set opacityListen(int value) => opacityListenRx.value = value;
  int get opacityListen => opacityListenRx.value;

  /// 透明度
  final RxDouble _opacity = 1.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;

  /// 图片数组
  final RxList<String> _imagesList = <String>[].obs;
  set imagesList(List<String> value) => _imagesList.value = value;
  RxList<String> get imagesList => _imagesList;
}
