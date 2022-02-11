import 'package:get/get.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 令牌 token
  String token = '';
  bool isOfflineLogin = false;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(storageUserTokenKey);
    if (token.isNotEmpty) isOfflineLogin = true;
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(storageUserTokenKey, value);
    token = value;
  }
}
