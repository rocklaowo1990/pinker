import 'package:get/get.dart';

class MoneyState {
  /// 胡牌玩家ID
  final RxInt _huId = 100.obs;
  set huId(int value) => _huId.value = value;
  int get huId => _huId.value;

  final RxList<int> _resault = [-20, 0, 200, 0].obs;
  set resault(List<int> value) => _resault.value = value;
  List<int> get resault => _resault;

  final RxList<Map<dynamic, dynamic>> _play = [{}, {}, {}, {}].obs;
  set play(List<Map<dynamic, dynamic>> value) => _play.value = value;
  List<Map<dynamic, dynamic>> get play => _play;
}
