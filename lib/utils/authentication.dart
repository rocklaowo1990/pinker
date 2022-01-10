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

Future<void> getUserInfo() async {
  final ApplicationController applicationController = Get.find();

  ResponseEntity _info = await UserApi.info();
  if (_info.code == 200) {
    applicationController.state.userInfo.value =
        UserInfoEntities.fromJson(_info.data);
    applicationController.state.userInfo.update((val) {});
  } else {
    getSnackTop(_info.msg);
  }
}

/// 刷新首页的推文列表
///
/// 这里是重置
///
/// 重新请求首页的推文列表
Future<void> getHomeContentList() async {
  final ApplicationController applicationController = Get.find();

  ResponseEntity responseEntity = await ContentApi.homeContentList(pageNo: 1);
  if (responseEntity.code == 200) {
    applicationController.state.contentListHome.value =
        ContentListEntities.fromJson(responseEntity.data);
    applicationController.state.contentListHome.update((val) {});
  } else {
    getSnackTop(responseEntity.msg);
  }

  applicationController.state.isLoading = false;
}

/// 重新请求推文列表
///
/// 可用于下拉刷新
Future<void> getContentList({
  required Rx<ContentListEntities> listRx,
  required int type,
  required int pageNo,
}) async {
  final ApplicationController applicationController = Get.find();

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
  applicationController.state.isLoading = false;
}

/// 这里是屏蔽或者隐藏用户后，用来刷新推文列表
///
/// 刷新首页，最新，最热，限免，和用户信息
Future<void> onHideContentList({
  required int userId,
}) async {
  final ApplicationController applicationController = Get.find();
  await getUserInfo();

  for (int i = 0;
      i < applicationController.state.contentListHome.value.list.length;
      i++) {
    if (applicationController
            .state.contentListHome.value.list[i].author.userId ==
        userId) {
      applicationController.state.contentListHome.update((val) {
        val!.list.remove(val.list[i]);
      });
    }
  }
  for (int i = 0;
      i < applicationController.state.contentListNew.value.list.length;
      i++) {
    if (applicationController
            .state.contentListNew.value.list[i].author.userId ==
        userId) {
      applicationController.state.contentListNew.update((val) {
        val!.list.remove(val.list[i]);
      });
    }
  }
  for (int i = 0;
      i < applicationController.state.contentListHot.value.list.length;
      i++) {
    if (applicationController
            .state.contentListHot.value.list[i].author.userId ==
        userId) {
      applicationController.state.contentListHot.update((val) {
        val!.list.remove(val.list[i]);
      });
    }
  }
  for (int i = 0;
      i < applicationController.state.contentListFree.value.list.length;
      i++) {
    if (applicationController
            .state.contentListFree.value.list[i].author.userId ==
        userId) {
      applicationController.state.contentListFree.update((val) {
        val!.list.remove(val.list[i]);
      });
    }
  }
}

/// 订阅推文后，刷新列表中该用户的所有其他推文
///
/// 用来更新的
Future<void> onRefreshContentList({
  required int userId,
}) async {
  final ApplicationController applicationController = Get.find();
  for (int i = 0;
      i < applicationController.state.contentListHome.value.list.length;
      i++) {
    if (applicationController
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
  }

  for (int i = 0;
      i < applicationController.state.contentListHot.value.list.length;
      i++) {
    if (applicationController
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
  }

  for (int i = 0;
      i < applicationController.state.contentListNew.value.list.length;
      i++) {
    if (applicationController
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
  }

  for (int i = 0;
      i < applicationController.state.contentListFree.value.list.length;
      i++) {
    if (applicationController
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
  }
}

/// 重置推文列表
///
/// 重置用户数据
Future<void> getContentListAll() async {
  final ApplicationController applicationController = Get.find();

  await getHomeContentList();

  await getContentList(
    listRx: applicationController.state.contentListNew,
    type: 2,
    pageNo: 1,
  );

  await getContentList(
    listRx: applicationController.state.contentListHot,
    type: 3,
    pageNo: 1,
  );

  await getContentList(
    listRx: applicationController.state.contentListFree,
    type: 6,
    pageNo: 1,
  );

  await getUserInfo();
}

/// 重置推文列表
///
/// 重置用户数据
Future<void> getContentOnly({
  required int wid,
}) async {
  final ApplicationController applicationController = Get.find();
  for (int i = 0;
      i < applicationController.state.contentListHome.value.list.length;
      i++) {
    if (applicationController.state.contentListHome.value.list[i].wid == wid) {
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
    if (applicationController.state.contentListHot.value.list[i].wid == wid) {
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
    if (applicationController.state.contentListNew.value.list[i].wid == wid) {
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
    if (applicationController.state.contentListFree.value.list[i].wid == wid) {
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
