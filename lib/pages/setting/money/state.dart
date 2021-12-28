import 'package:get/get.dart';

class MoneyState {
  /// 胡牌玩家ID
  final RxInt _huId = 100.obs;
  set huId(int value) => _huId.value = value;
  int get huId => _huId.value;

  final RxList<int> resault = [0, 0, 0, 0].obs;

  final RxList<int> resaultOnly = [0, 0, 0, 0].obs;

  final RxList<int> public = [0, 0, 0, 0].obs;

  final RxList<List<int>> ma = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ].obs;

  final RxList<List<Map<String, int>>> payOnly = [
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

  final RxList<List<Map<String, int>>> shouOnly = [
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
}
