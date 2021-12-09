import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pinker/api/content.dart';
import 'package:pinker/entities/content_list.dart';
import 'package:pinker/entities/response.dart';
import 'package:pinker/pages/application/home/library.dart';
import 'package:pinker/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  HomeController();
  final HomeState state = HomeState();

  VideoPlayerController? videoPlayerController;

  void handleMail() {}

  @override
  void onReady() async {
    super.onReady();

    Map<String, dynamic> data = {
      'type': 1,
    };

    ResponseEntity responseEntity = await ContentApi.contentList(data);
    if (responseEntity.code == 200) {
      ContentList contentList = ContentList.fromJson(responseEntity.data!);
      state.showList.addAll(contentList.list);
      state.isLoading = false;
    } else {
      getSnackTop(responseEntity.msg);
    }
  }
}
