import 'package:flutter/material.dart';
import 'package:video_player_test/presentation/screens/home_screen/home_screen_controller.dart';

import 'components/video_item_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = HomeScreenController();
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: homeScreenController.availableVideos.length,
          itemBuilder: (context, index) {
            final videoDetails = homeScreenController.availableVideos[index];
            return VideoItemHome(
              videoDetails: videoDetails,
            );
          }),
    );
  }
}
