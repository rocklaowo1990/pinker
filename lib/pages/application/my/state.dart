import 'package:get/get.dart';

class MyState {
  /// appbar 透明度
  final RxDouble _opacity = 0.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;

  /// 头像
  final RxString _avatar = ''.obs;
  set avatar(String value) => _avatar.value = value;
  String get avatar => _avatar.value;

  /// 钻石金额
  final RxInt _diamondBalance = 0.obs;
  set diamondBalance(int value) => _diamondBalance.value = value;
  int get diamondBalance => _diamondBalance.value;

  /// 用户名
  final RxString _userName = 'userName'.obs;
  set userName(String value) => _userName.value = value;
  String get userName => _userName.value;

  /// 昵称
  final RxString _nickName = '您的昵称'.obs;
  set nickName(String value) => _nickName.value = value;
  String get nickName => _nickName.value;

  /// P币账户
  final RxInt _pCoinBalance = 0.obs;
  set pCoinBalance(int value) => _pCoinBalance.value = value;
  int get pCoinBalance => _pCoinBalance.value;

  /// 订阅的用户
  final RxInt _followCount = 0.obs;
  set followCount(int value) => _followCount.value = value;
  int get followCount => _followCount.value;

  /// 订阅的群聊
  final RxInt _subChatCount = 0.obs;
  set subChatCount(int value) => _subChatCount.value = value;
  int get subChatCount => _subChatCount.value;
}
