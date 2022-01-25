import 'package:get/get.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/personal.dart';

class PersonalState {
  /// appbar 透明度
  final RxDouble _opacity = 0.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;

  /// 页面控制器
  final RxInt pageIndexRx = 0.obs;
  set pageIndex(int value) => pageIndexRx.value = value;
  int get pageIndex => pageIndexRx.value;

  final intro = PersonalEntities.fromJson(PersonalEntities.child).obs;

  final personalAll =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  final personalFree =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  final personalReply =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  final personalForward =
      ContentListEntities.fromJson(ContentListEntities.child).obs;

  final personalLike =
      ContentListEntities.fromJson(ContentListEntities.child).obs;
}
