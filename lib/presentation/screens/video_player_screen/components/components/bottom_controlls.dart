import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_test/utils/constants.dart';

class BottomControlls extends StatelessWidget {
  const BottomControlls({Key? key, required this.videoPlayerController})
      : super(key: key);

  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    void touglePausePlay() {
      videoPlayerController.value.isPlaying
          ? videoPlayerController.pause()
          : videoPlayerController.play();
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black38],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingSmall, vertical: defaultPaddingSmall),
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: Row(
            children: [
              InkWell(
                onTap: touglePausePlay,
                child: Icon(
                  videoPlayerController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: defaultPadding * 3,
                ),
              ),
              defaultSpacerHorizontalSmall,
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: AnimatedBuilder(
                                animation: videoPlayerController,
                                builder: (context, child) {
                                  return Slider(
                                    value: videoPlayerController
                                        .value.position.inMilliseconds
                                        .toDouble(),
                                    min: 0,
                                    max: videoPlayerController
                                        .value.duration.inMilliseconds
                                        .toDouble(),
                                    onChanged: (mills) =>
                                        videoPlayerController.seekTo(Duration(
                                            milliseconds: mills.toInt())),
                                  );
                                })),
                        Text(
                          "03:47/10:00",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 10, color: Colors.white),
                        )
                      ],
                    ),
                    defaultSpacerSmall,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.skip_previous),
                        ),
                        defaultSpacerHorizontal,
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.skip_next),
                        ),
                        defaultSpacerHorizontal,
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.volume_up),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.settings),
                        ),
                        defaultSpacerHorizontal,
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.fullscreen),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
