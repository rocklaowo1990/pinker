import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/application/library.dart';
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
  // await StorageUtil().remove(storageUserInfoKey);
  // await StorageUtil().remove(storageIsHadUserInfo);
  // await StorageUtil().remove(storageHomeContentListKey);
  // await StorageUtil().remove(storageNewContentListKey);
  // await StorageUtil().remove(storageIsHadNewContent);
  // await StorageUtil().remove(storageHotContentListKey);
  // await StorageUtil().remove(storageIsHadHotContent);
  Global.token = null;
  Global.isOfflineLogin = false;
  // Global.isHadUserInfo = false;
}

/// 重新登录
Future goLoginPage() async {
  await deleteAuthentication();
  Get.offAllNamed(AppRoutes.frame);
}

Future<void> getUserInfo(Rx<UserInfoEntities> userInfo) async {
  ResponseEntity _info = await UserApi.info();
  if (_info.code == 200) {
    // await StorageUtil().setJSON(storageUserInfoKey, _info.data);
    userInfo.value = UserInfoEntities.fromJson(_info.data);
    userInfo.update((val) {});
    // await StorageUtil().setBool(storageIsHadUserInfo, true);
    // Global.isHadUserInfo = true;
  } else {
    getSnackTop(_info.msg);
  }
}

Future<void> getHomeContentList(Rx<ContentListEntities> listRx) async {
  ResponseEntity responseEntity = await ContentApi.homeContentList(pageNo: 1);

  if (responseEntity.code == 200) {
    listRx.value = ContentListEntities.fromJson(responseEntity.data);
    listRx.update((val) {});
  } else {
    getSnackTop(responseEntity.msg);
  }
}

Future<void> getContentList({
  required Rx<ContentListEntities> listRx,
  required int type,
  required int pageNo,
}) async {
  ResponseEntity responseEntity = await ContentApi.contentList(
    pageNo: pageNo,
    type: type,
  );
  if (responseEntity.code == 200) {
    listRx.value = ContentListEntities.fromJson(responseEntity.data);
    listRx.update((val) {});
  } else {
    getSnackTop(responseEntity.msg);
  }
}

Future<void> onRefreshContentList({
  int? userId,
  int? wid,
}) async {
  final ApplicationController applicationController = Get.find();
  for (int i = 0;
      i < applicationController.state.contentListHome.value.list.length;
      i++) {
    if (userId != null &&
        applicationController
                .state.contentListHome.value.list[i].author.userId ==
            userId) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListHome.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListHome.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
    if (wid != null &&
        applicationController.state.contentListHome.value.list[i].wid == wid) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListHome.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListHome.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
  }

  for (int i = 0;
      i < applicationController.state.contentListHot.value.list.length;
      i++) {
    if (userId != null &&
        applicationController
                .state.contentListHot.value.list[i].author.userId ==
            userId) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListHot.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListHot.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
    if (wid != null &&
        applicationController.state.contentListHot.value.list[i].wid == wid) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListHot.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListHot.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
  }

  for (int i = 0;
      i < applicationController.state.contentListNew.value.list.length;
      i++) {
    if (userId != null &&
        applicationController
                .state.contentListNew.value.list[i].author.userId ==
            userId) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListNew.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListNew.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
    if (wid != null &&
        applicationController.state.contentListNew.value.list[i].wid == wid) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListNew.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListNew.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
  }

  for (int i = 0;
      i < applicationController.state.contentListFree.value.list.length;
      i++) {
    if (userId != null &&
        applicationController
                .state.contentListFree.value.list[i].author.userId ==
            userId) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListFree.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListFree.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
    if (wid != null &&
        applicationController.state.contentListFree.value.list[i].wid == wid) {
      ResponseEntity _userinfo = await ContentApi.contentDetail(
          wid: applicationController.state.contentListFree.value.list[i].wid);
      if (_userinfo.code == 200) {
        applicationController.state.contentListFree.update((val) {
          val!.list[i] = ContentDetailElement.fromJson(_userinfo.data);
        });
      } else {
        getSnackTop(_userinfo.msg);
      }
    }
  }
}
