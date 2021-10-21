import 'package:get/get.dart';

class CodeListState {
  /// 区号列表
  final RxList<dynamic> _codeList = [].obs;
  set codeList(value) => _codeList.value = value;
  // ignore: invalid_use_of_protected_member
  List<dynamic> get codeList => _codeList.value;
}
