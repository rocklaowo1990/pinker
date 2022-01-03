import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = StorageUtil().getJSON(storageUserTokenKey);
  return profileJSON != null ? true : false;
}

/// 删除缓存 token
Future deleteAuthentication() async {
  await StorageUtil().remove(storageUserTokenKey);
  await StorageUtil().remove(storageUserInfoKey);
  await StorageUtil().remove(storageIsHadUserInfo);

  await StorageUtil().remove(storageHomeContentListKey);

  // await StorageUtil().remove(storageNewContentListKey);
  // await StorageUtil().remove(storageIsHadNewContent);

  // await StorageUtil().remove(storageHotContentListKey);
  // await StorageUtil().remove(storageIsHadHotContent);

  Global.token = null;
  Global.isOfflineLogin = false;
  Global.isHadUserInfo = false;
}

/// 重新登录
Future goLoginPage() async {
  await deleteAuthentication();
  Get.offAllNamed(AppRoutes.frame);
}

Future<void> getUserInfo(
  Rx<UserInfoEntities> userInfo, {
  RxBool? isLoading,
}) async {
  ResponseEntity _info = await UserApi.info();
  if (_info.code == 200) {
    await StorageUtil().setJSON(storageUserInfoKey, _info.data);
    userInfo.value = UserInfoEntities.fromJson(_info.data);
    userInfo.update((val) {});
    await StorageUtil().setBool(storageIsHadUserInfo, true);
    Global.isHadUserInfo = true;
  } else {
    getSnackTop(_info.msg);
    if (isLoading != null) isLoading.value = false;
  }
}
