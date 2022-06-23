import 'package:flutter/material.dart';
import 'package:video_player_test/domain/entities/video_details.dart';

import '../video_list/video_list.dart';
import 'components/action_section.dart';
import 'components/video_player_section.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({
    Key? key,
    required this.videoDetails,
  }) : super(key: key);
  final VideoDetails videoDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VideoPlayerSection(
            videoDetails: videoDetails,
          ),
          ActionSection(
            videoDetails: videoDetails,
          ),
          const Expanded(child: VideoList())
        ],
      ),
    );
  }
}
