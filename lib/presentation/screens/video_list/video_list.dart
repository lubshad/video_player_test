import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/presentation/screens/home_screen/components/video_item_home.dart';
import 'package:video_player_test/presentation/screens/video_list/video_list_controller.dart';

class VideoList extends StatelessWidget {
  const VideoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoListController videoListController = Get.find();
    return AnimatedBuilder(
      animation: videoListController,
      builder: (BuildContext context, Widget? child) {
        return ListView.separated(
          separatorBuilder: ((context, index) => const Divider()),
          itemCount: videoListController.availableVideos.length,
          itemBuilder: (context, index) {
            final videoDetails = videoListController.availableVideos[index];
            return VideoItemHome(
              videoDetails: videoDetails,
            );
          },
        );
      },
    );
  }
}
