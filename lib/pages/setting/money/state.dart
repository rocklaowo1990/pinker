import 'package:get/get.dart';

class MoneySystems {
  MoneySystems({
    required this.playerId,
    required this.resault,
    required this.beBuy,
    required this.ji,
    required this.only_1,
    required this.only_2,
    required this.only_3,
    required this.ma_1,
    required this.ma_2,
    required this.ma_3,
    required this.ma_4,
  });

  int playerId;
  int resault;
  int beBuy;
  int ji;

  int only_1;
  int only_2;
  int only_3;

  int ma_1;
  int ma_2;
  int ma_3;
  int ma_4;

  factory MoneySystems.fromJson(Map<String, dynamic> json) => MoneySystems(
        playerId: json["playerId"],
        resault: json["resault"],
        beBuy: json["beBuy"],
        ji: json["ji"],
        only_1: json["only_1"],
        only_2: json["only_2"],
        only_3: json["only_3"],
        ma_1: json["ma_1"],
        ma_2: json["ma_2"],
        ma_3: json["ma_3"],
        ma_4: json["ma_4"],
      );

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'resault': resault,
        'beBuy': beBuy,
        'ji': ji,
        'only_1': only_1,
        'only_2': only_2,
        'only_3': only_3,
        'ma_1': ma_1,
        'ma_2': ma_2,
        'ma_3': ma_3,
        'ma_4': ma_4,
      };
}

class MoneyState {
  final Rx<MoneySystems> _player_1 = MoneySystems.fromJson({
    'playerId': 1,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;
  set player_1(MoneySystems value) => _player_1.value = value;
  MoneySystems get player_1 => _player_1.value;

  final Rx<MoneySystems> _player_2 = MoneySystems.fromJson({
    'playerId': 1,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;
  set player_2(MoneySystems value) => _player_2.value = value;
  MoneySystems get player_2 => _player_2.value;

  final Rx<MoneySystems> _player_3 = MoneySystems.fromJson({
    'playerId': 1,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;
  set player_3(MoneySystems value) => _player_3.value = value;
  MoneySystems get player_3 => _player_3.value;

  final Rx<MoneySystems> _player_4 = MoneySystems.fromJson({
    'playerId': 1,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;
  set player_4(MoneySystems value) => _player_4.value = value;
  MoneySystems get player_4 => _player_4.value;

  final RxBool _isReset = false.obs;
  set isReset(value) => _isReset.value = value;
  bool get isReset => _isReset.value;
}
