// lib/ui/videoList/controller/video_player_controller.dart

import 'dart:developer'; // <-- for log()
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/vide_table.dart';
import 'package:akkha_rik_lipi_sipal/ui/videoList/controller/video_list_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../utils/utils.dart';

class VideoPlayerController extends GetxController {
  final args = Get.arguments;
  int index = 0;

  late final YoutubePlayerController controller;
  final List<VideoTable>? itemDataList =
      Get.find<VideoListController>().videoList;

  bool isPlayerReady = false;
  bool isFullScreen = false;
  late PlayerState playerState;

  final List<String> videoIds = [];
  final List<String> videoTitle = [];
  final List<String> videoThumb = [];

  @override
  void onInit() {
    super.onInit();
    _getDataFromArgs();
    _extractVideoIds();

    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    Utils.audioPlayer.pause();

    controller.setFullScreenListener((fullscreen) {
      isFullScreen = fullscreen;
      log('${fullscreen ? 'Entered' : 'Exited'} fullscreen.');
    });

    controller.loadPlaylist(
      list: videoIds,
      listType: ListType.playlist,
      startSeconds: 0,
      index: index,
    );
  }

  void _getDataFromArgs() {
    if (args != null && args is List && args.isNotEmpty) {
      final arg0 = args[0];
      if (arg0 is int) {
        index = arg0;
      }
    }
  }

  void _extractVideoIds() {
    for (final e in itemDataList ?? []) {
      final desc = e.videoDescription ?? '';
      final parts = desc.split('#');
      final id = parts.isNotEmpty ? parts[0].trim() : '';
      final title = parts.length > 1 ? parts.sublist(1).join(':').trim() : '';
      final thumb = 'https://i3.ytimg.com/vi/$id/hqdefault.jpg';

      videoIds.add(id);
      videoTitle.add(title);
      videoThumb.add(thumb);
    }

    // use log() instead of print()
    log('Extracted video IDs: $videoIds');
  }

  void changeVideo(int newIndex) {
    index = newIndex;
    controller.playVideoAt(index);
    update();
  }

  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
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
