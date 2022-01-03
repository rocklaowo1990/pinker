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
    required this.onlyId_1,
    required this.onlyId_2,
    required this.onlyId_3,
    required this.ma_1,
    required this.ma_2,
    required this.ma_3,
    required this.ma_4,
  });

  int playerId = 0;
  int resault = 0;
  int beBuy = 0;
  int ji = 0;

  int only_1 = 0;
  int only_2 = 0;
  int only_3 = 0;

  int onlyId_1 = 0;
  int onlyId_2 = 0;
  int onlyId_3 = 0;

  int ma_1 = 0;
  int ma_2 = 0;
  int ma_3 = 0;
  int ma_4 = 0;

  factory MoneySystems.fromJson(Map<String, dynamic> json) => MoneySystems(
        playerId: json["playerId"],
        resault: json["resault"],
        beBuy: json["beBuy"],
        ji: json["ji"],
        only_1: json["only_1"],
        only_2: json["only_2"],
        only_3: json["only_3"],
        onlyId_1: json["onlyId_1"],
        onlyId_2: json["onlyId_2"],
        onlyId_3: json["onlyId_3"],
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
        'onlyId_1': onlyId_1,
        'onlyId_2': onlyId_2,
        'onlyId_3': onlyId_3,
        'ma_1': ma_1,
        'ma_2': ma_2,
        'ma_3': ma_3,
        'ma_4': ma_4,
      };
}

class MoneyState {
  final player_1 = MoneySystems.fromJson({
    'playerId': 1,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'onlyId_1': 2,
    'onlyId_2': 3,
    'onlyId_3': 4,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;
  final player_2 = MoneySystems.fromJson({
    'playerId': 2,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'onlyId_1': 1,
    'onlyId_2': 3,
    'onlyId_3': 4,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;
  final player_3 = MoneySystems.fromJson({
    'playerId': 3,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'onlyId_1': 1,
    'onlyId_2': 2,
    'onlyId_3': 4,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;
  final player_4 = MoneySystems.fromJson({
    'playerId': 4,
    'resault': 0,
    'beBuy': 0,
    'ji': 0,
    'only_1': 0,
    'only_2': 0,
    'only_3': 0,
    'onlyId_1': 1,
    'onlyId_2': 2,
    'onlyId_3': 3,
    'ma_1': 0,
    'ma_2': 0,
    'ma_3': 0,
    'ma_4': 0,
  }).obs;

  final RxBool _isReset = false.obs;
  set isReset(value) => _isReset.value = value;
  bool get isReset => _isReset.value;
}
