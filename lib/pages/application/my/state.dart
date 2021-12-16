import 'package:get/get.dart';

class MyState {
  /// appbar 透明度
  final RxDouble _opacity = 0.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;
}
