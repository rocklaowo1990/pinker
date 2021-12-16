import 'package:get/get.dart';
import 'package:pinker/api/api.dart';

import 'package:pinker/api/content.dart';

import 'package:pinker/entities/entities.dart';

import 'package:pinker/global.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final ApplicationController applicationController = Get.find();

  int pageIndex = 1;
  int totalSize = 0;

  void handleMail() {}

  void onRefresh() async {
    refreshController.resetNoData();

    await futureMill(1000);
    _refresh();
    await futureMill(1000);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await futureMill(2000);
    if (totalSize >= 20) {
      pageIndex++;
      Map<String, dynamic> data = {
        'pageNo': pageIndex,
        'pageSize': 20,
        'type': 2,
      };

      ResponseEntity responseEntity = await ContentApi.contentList(data);

      if (responseEntity.code == 200) {
        ContentList contentList = ContentList.fromJson(responseEntity.data);
        state.showList.addAll(contentList.list);
        state.isLoading = false;
        totalSize = contentList.totalSize;
        refreshController.loadComplete();
        Map<String, dynamic> _storageUserContentList = {
          'list': state.showList,
          'totalSize': state.showList.length,
        };
        await StorageUtil()
            .setJSON(storageUserContentListKey, _storageUserContentList);
      } else {
        pageIndex--;
        refreshController.loadFailed();

        getSnackTop(responseEntity.msg);
      }
    } else {
      refreshController.loadNoData();
    }

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  Future<void> _refresh() async {
    pageIndex = 1;
    totalSize = 0;
    Map<String, dynamic> data = {
      'pageNo': 1,
      'pageSize': 20,
      'type': 2,
    };

    ResponseEntity responseEntity = await ContentApi.contentList(data);
    if (responseEntity.code == 200) {
      ContentList contentList = ContentList.fromJson(responseEntity.data);
      state.showList.clear();
      state.showList.addAll(contentList.list);
      state.isLoading = false;
      totalSize = contentList.totalSize;
      await StorageUtil()
          .setJSON(storageUserContentListKey, responseEntity.data);
      await StorageUtil().setBool(storageIsHadUserInfo, true);
      Global.isHadUserInfo = true;
    } else {
      getSnackTop(responseEntity.msg);
      state.isLoading = false;
    }
  }

  Future<void> _getUserInfo() async {
    ResponseEntity _info = await UserApi.info();
    if (_info.code == 200) {
      await StorageUtil().setJSON(storageUserInfoKey, _info.data);
      applicationController.state.userInfoMap = _info.data;
    } else {
      getSnackTop(_info.msg);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    if (Global.isHadUserInfo) {
      state.isLoading = false;
      Map<String, dynamic> _contentList =
          await StorageUtil().getJSON(storageUserContentListKey);
      ContentList contentList = ContentList.fromJson(_contentList);

      pageIndex = contentList.list.length ~/ 20;
      totalSize =
          contentList.list.length % 20 == 0 ? 20 : contentList.list.length % 20;

      state.showList.addAll(contentList.list);

      // 个人信息
      // 读取用户信息
      final _userInfo = await StorageUtil().getJSON(storageUserInfoKey);
      applicationController.state.userInfoMap = _userInfo;
    } else {
      await _refresh();
      await _getUserInfo();
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
