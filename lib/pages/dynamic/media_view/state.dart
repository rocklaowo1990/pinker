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

  /// 透明度监听
  final RxInt _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;

  /// 是否全屏
  final RxBool _isFullScreen = false.obs;
  set isFullScreen(bool value) => _isFullScreen.value = value;
  bool get isFullScreen => _isFullScreen.value;

  /// 是否显示播放器控制条
  final RxBool _isShowVideoController = false.obs;
  set isShowVideoController(bool value) => _isShowVideoController.value = value;
  bool get isShowVideoController => _isShowVideoController.value;
}
