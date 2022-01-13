import 'package:get/get.dart';
import 'package:pinker/api/api.dart';
import 'package:pinker/entities/entities.dart';
import 'package:pinker/entities/user_list.dart';
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
  // Global.isHadUserInfo = false;

  Global.token = null;
  Global.isOfflineLogin = false;
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
}

/// 刷新首页的其他数据
///
/// 包括banner，金刚区，活动，和推荐列表
///
/// 重新请求会刷新
Future<void> getRecommendList(int pageNo) async {
  final ApplicationController applicationController = Get.find();

  ResponseEntity responseEntity = await UserApi.list(type: 2, pageNo: pageNo);

  if (responseEntity.code == 200) {
    applicationController.state.recommendUserList.value =
        UserListEntities.fromJson(responseEntity.data);
    applicationController.state.recommendUserList.update((val) {});
  } else {
    getSnackTop(responseEntity.msg);
  }
}

/// 重新请求推文列表
///
/// 可用于下拉刷新
Future<void> getContentList(
    {required Rx<ContentListEntities> listRx,
    required int type,
    required int pageNo,
    String? keywords}) async {
  ResponseEntity responseEntity = await ContentApi.contentList(
      pageNo: pageNo, type: type, keywords: keywords);
  if (responseEntity.code == 200) {
    listRx.value = ContentListEntities.fromJson(responseEntity.data);
    listRx.update((val) {});
  } else {
    getSnackTop(responseEntity.msg);
  }
}

/// 这里是屏蔽或者隐藏用户后，用来刷新推文列表
///
/// 刷新首页，最新，最热，限免，和用户信息
void onHideContentList({
  required int userId,
}) {
  final ApplicationController applicationController = Get.find();

  applicationController.state.contentListHome.update((val) {
    val!.list.removeWhere((element) => element.author.userId == userId);
  });

  if (applicationController.state.contentListHot.value.list.isNotEmpty) {
    applicationController.state.contentListHot.update((val) {
      val!.list.removeWhere((element) => element.author.userId == userId);
    });
  }

  if (applicationController.state.contentListNew.value.list.isNotEmpty) {
    applicationController.state.contentListNew.update((val) {
      val!.list.removeWhere((element) => element.author.userId == userId);
    });
  }

  if (applicationController.state.contentListFree.value.list.isNotEmpty) {
    applicationController.state.contentListFree.update((val) {
      val!.list.removeWhere((element) => element.author.userId == userId);
    });
  }
}

/// 订阅推文后，刷新列表中该用户的所有其他推文
///
/// 用来更新的
Future<void> onRefreshContentList({
  required int userId,
}) async {
  final ApplicationController applicationController = Get.find();

  Future<void> _r(Rx<ContentListEntities> rx) async {
    if (rx.value.list.isNotEmpty) {
      for (int i = 0; i < rx.value.list.length; i++) {
        if (rx.value.list[i].author.userId == userId) {
          ResponseEntity _userinfo = await ContentApi.contentDetail(
            wid: rx.value.list[i].wid,
          );
          if (_userinfo.code == 200) {
            rx.update((val) {
              val!.list[i] = ContentDetailElement.fromJson(
                _userinfo.data,
              );
            });
          } else {
            getSnackTop(_userinfo.msg);
          }
        }
      }
    }
  }

  await _r(applicationController.state.contentListHome);
  await _r(applicationController.state.contentListHot);
  await _r(applicationController.state.contentListNew);
  await _r(applicationController.state.contentListFree);
}

/// 重置推文列表-全部刷新
///
/// 重置用户数据
Future<void> getContentListAll() async {
  final ApplicationController applicationController = Get.find();

  await getHomeContentList();

  if (applicationController.state.contentListHome.value.list.isNotEmpty) {
    await getContentList(
      listRx: applicationController.state.contentListNew,
      type: 2,
      pageNo: 1,
    );
  }

  if (applicationController.state.contentListHot.value.list.isNotEmpty) {
    await getContentList(
      listRx: applicationController.state.contentListHot,
      type: 3,
      pageNo: 1,
    );
  }

  if (applicationController.state.contentListFree.value.list.isNotEmpty) {
    await getContentList(
      listRx: applicationController.state.contentListFree,
      type: 6,
      pageNo: 1,
    );
  }

  await getUserInfo();
}

/// 重置推文列表-单独
///
/// 重置用户数据
Future<void> getContentOnly({
  required int wid,
}) async {
  final ApplicationController applicationController = Get.find();

  Future<void> _r(Rx<ContentListEntities> rx) async {
    if (rx.value.list.isNotEmpty) {
      for (int i = 0; i < rx.value.list.length; i++) {
        if (rx.value.list[i].wid == wid) {
          ResponseEntity _userinfo = await ContentApi.contentDetail(wid: wid);
          if (_userinfo.code == 200) {
            rx.update((val) {
              val!.list[i] = ContentDetailElement.fromJson(
                _userinfo.data,
              );
            });
          } else {
            getSnackTop(_userinfo.msg);
          }
        }
      }
    }
  }

  await _r(applicationController.state.contentListHome);
  await _r(applicationController.state.contentListHot);
  await _r(applicationController.state.contentListNew);
  await _r(applicationController.state.contentListFree);
}
