import 'dart:io';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_test/domain/entities/video_details.dart';
import 'package:video_player_test/presentation/screens/downloads_listing/downloads_listing_controller.dart';

import '../../../../utils/constants.dart';
import 'components/bottom_controlls.dart';

class VideoPlayerSection extends StatefulWidget with WidgetsBindingObserver {
  const VideoPlayerSection({
    Key? key,
    required this.videoDetails,
  }) : super(key: key);

  final VideoDetails videoDetails;

  @override
  State<VideoPlayerSection> createState() => _VideoPlayerSectionState();
}

class _VideoPlayerSectionState extends State<VideoPlayerSection> {
  late VideoPlayerController videoPlayerController;
  DownloadsListingController downloadsListingController = Get.find();
  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.network(widget.videoDetails.videoUrl);
    checkFileDownloaded();
    super.initState();
  }

  checkFileDownloaded() async {
    var downloadedItem = downloadsListingController.downloadedVideos
        .firstWhereOrNull((element) => element.id == widget.videoDetails.id);
    if (downloadedItem != null) {
      loadFromLocal(downloadedItem);
    } else {
      videoPlayerController
          .initialize()
          .then((value) => videoPlayerController.play());
    }
  }

  loadFromLocal(VideoDetails videoDetails) async {
    logger.info("loading from local");
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final appDir = await getExternalStorageDirectory();
      final File file = File("${appDir!.path}/${videoDetails.title}.mp4");
      if (await file.exists()) {
        videoPlayerController = VideoPlayerController.file(file);
      } else {
        logger.info("no file");
      }
    } else {
      logger.info("Permission deined");
    }
    setState(() {});
    videoPlayerController
        .initialize()
        .then((value) => videoPlayerController.play());
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      videoPlayerController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: landscapeAspectRatio,
      child: AnimatedBuilder(
          animation: videoPlayerController,
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                    color: Colors.black,
                    child: !videoPlayerController.value.isInitialized
                        ? const DefaultLoadingWidget()
                        : VideoPlayer(videoPlayerController)),
                Visibility(
                    visible: videoPlayerController.value.isInitialized,
                    child: BottomControlls(
                        videoPlayerController: videoPlayerController)),
              ],
            );
          }),
    );
  }
}
