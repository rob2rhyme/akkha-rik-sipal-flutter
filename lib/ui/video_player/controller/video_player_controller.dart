import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/tables/vide_table.dart';
import 'package:kids_playroom/ui/videoList/controller/video_list_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../utils/utils.dart';

class VideoPlayerController extends GetxController {
  dynamic args = Get.arguments;

  int index = 0;
  late YoutubePlayerController  controller;
  List<VideoTable>? itemDataList = Get.find<VideoListController>().videoList;
  bool isPlayerReady = false;
  late PlayerState playerState;


  getVideoId() {
    itemDataList?.forEach((e) {
      var str = e.videoDescription;
      var parts = str?.split('#');
      var id = parts?[0].trim() ?? "";
      var title = parts?.sublist(1).join(':').trim() ?? "";
      var thumb = "https://i3.ytimg.com/vi/$id/hqdefault.jpg";

      videoIds.add(id);
      videoTitle.add(title);
      videoThumb.add(thumb);
    });
    print("::::::::::::$videoIds");
  }

  List<String> videoIds = [];
  List<String> videoTitle = [];
  List<String> videoThumb = [];

  @override
  void onInit() {
    getDataFromArgs();
    getVideoId();
        controller = YoutubePlayerController(
          initialVideoId: videoIds[index],
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,

          ),
        );
    Utils.audioPlayer.pause();

    super.onInit();
  }
  void listener() {
    if (isPlayerReady  && !controller.value.isFullScreen) {
        playerState = controller.value.playerState;
        update();
    }
  }
  changeVideo(int indexID) {
    index = indexID;
    controller
        .load(videoIds[indexID]);
    update();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        index = args[0];
      }
    }
  }
  void showSnackBar(String message,BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

}
