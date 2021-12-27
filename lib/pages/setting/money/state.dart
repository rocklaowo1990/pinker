import 'package:get/get.dart';

class MoneyState {
  /// 胡牌玩家ID
  final RxInt _huId = 100.obs;
  set huId(int value) => _huId.value = value;
  int get huId => _huId.value;

  final RxList<int> _resault = [0, 0, 0, 0].obs;
  set resault(List<int> value) => _resault.value = value;
  List<int> get resault => _resault;

  final RxList<int> _resaultOnly = [0, 0, 0, 0].obs;
  set resaultOnly(List<int> value) => _resaultOnly.value = value;
  List<int> get resaultOnly => _resaultOnly;

  final RxList<int> _public = [0, 0, 0, 0].obs;
  set public(List<int> value) => _public.value = value;
  List<int> get public => _public;

  final RxList<List<int>> _ma = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ].obs;
  set ma(List<List<int>> value) => _ma.value = value;
  List<List<int>> get ma => _ma;

  final RxList<List<Map<String, int>>> _payOnly = [
    [
      {
        'id': 1,
        'number': 0,
      },
      {
        'id': 2,
        'number': 0,
      },
      {
        'id': 3,
        'number': 0,
      }
    ],
    [
      {
        'id': 0,
        'number': 0,
      },
      {
        'id': 2,
        'number': 0,
      },
      {
        'id': 3,
        'number': 0,
      }
    ],
    [
      {
        'id': 0,
        'number': 0,
      },
      {
        'id': 1,
        'number': 0,
      },
      {
        'id': 3,
        'number': 0,
      }
    ],
    [
      {
        'id': 0,
        'number': 0,
      },
      {
        'id': 1,
        'number': 0,
      },
      {
        'id': 2,
        'number': 0,
      }
    ],
  ].obs;
  set payOnly(List<List<Map<String, int>>> value) => _payOnly.value = value;
  List<List<Map<String, int>>> get payOnly => _payOnly;

  final RxList<List<Map<String, int>>> _shouOnly = [
    [
      {
        'id': 1,
        'number': 0,
      },
      {
        'id': 2,
        'number': 0,
      },
      {
        'id': 3,
        'number': 0,
      }
    ],
    [
      {
        'id': 0,
        'number': 0,
      },
      {
        'id': 2,
        'number': 0,
      },
      {
        'id': 3,
        'number': 0,
      }
    ],
    [
      {
        'id': 0,
        'number': 0,
      },
      {
        'id': 1,
        'number': 0,
      },
      {
        'id': 3,
        'number': 0,
      }
    ],
    [
      {
        'id': 0,
        'number': 0,
      },
      {
        'id': 1,
        'number': 0,
      },
      {
        'id': 2,
        'number': 0,
      }
    ],
  ].obs;
  set shouOnly(List<List<Map<String, int>>> value) => _shouOnly.value = value;
  List<List<Map<String, int>>> get shouOnly => _shouOnly;
}
