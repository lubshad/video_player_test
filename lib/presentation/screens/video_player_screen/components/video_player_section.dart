import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../utils/constants.dart';
import 'components/bottom_controlls.dart';

class VideoPlayerSection extends StatefulWidget with WidgetsBindingObserver {
  const VideoPlayerSection({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<VideoPlayerSection> createState() => _VideoPlayerSectionState();
}

class _VideoPlayerSectionState extends State<VideoPlayerSection> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    videoPlayerController
        .initialize()
        .then((value) => videoPlayerController.play());
    super.initState();
  }

  @override
  void dispose() {
    // videoPlayerController.pause();
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
