import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

Widget getVideoController(
  FijkPlayer fijkPlayer,
  VoidCallback onExit,
  VoidCallback onEnter,
) {
  RxInt videoTimeListen = 0.obs;

  RxInt videoTime = fijkPlayer.currentPos.inMilliseconds.toInt().obs;

  RxBool isPlay = fijkPlayer.state == FijkState.started ? true.obs : false.obs;

  fijkPlayer.addListener(() {
    fijkPlayer.value.fullScreen ? onEnter() : onExit();
    isPlay.value = fijkPlayer.state == FijkState.started ? true : false;
  });

  fijkPlayer.onCurrentPosUpdate.listen((value) {
    videoTimeListen.value = value.inMilliseconds;
  });

  interval(videoTimeListen, (int value) {
    videoTime.value = videoTimeListen.value;
  }, time: const Duration(milliseconds: 500));

  return Container(
    width: double.infinity,
    height: 50,
    decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line, width: 1))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getButton(
          child: Obx(() => isPlay.value
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_circle)),
          onPressed: () {
            fijkPlayer.state == FijkState.started
                ? fijkPlayer.pause()
                : fijkPlayer.start();
          },
          height: 50,
          width: 50,
          background: Colors.transparent,
        ),
        Expanded(
            child: Obx(() => Slider(
                  value: videoTime.value.toDouble(),
                  min: 0.0,
                  max: fijkPlayer.value.duration.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    fijkPlayer.pause();
                    videoTime.value = value.toInt();
                  },
                  onChangeEnd: (value) async {
                    await fijkPlayer.seekTo(value.toInt());
                    fijkPlayer.start();
                  },
                ))),
        getButton(
          child: const Icon(Icons.fullscreen),
          onPressed: () {
            fijkPlayer.value.fullScreen
                ? fijkPlayer.exitFullScreen()
                : fijkPlayer.enterFullScreen();
          },
          height: 50,
          width: 50,
          background: Colors.transparent,
        ),
      ],
    ),
  );
}
