import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/domain/entities/video_details.dart';
import 'package:video_player_test/presentation/screens/downloads_listing/downloads_listing_controller.dart';
import 'package:video_player_test/presentation/screens/home_screen/components/video_item_home.dart';

class DownloadsListing extends StatelessWidget {
  const DownloadsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DownloadsListingController downloadsListingController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloads"),
      ),
      body: AnimatedBuilder(
          animation: downloadsListingController,
          builder: (context, child) {
            if (downloadsListingController.downloadedVideos.isEmpty) {
              return const Center(
                child: Text("No Data found"),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) => Builder(builder: (context) {
                      VideoDetails videoDetails =
                          downloadsListingController.downloadedVideos[index];
                      return VideoItemHome(videoDetails: videoDetails);
                    }),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: downloadsListingController.downloadedVideos.length);
          }),
    );
  }
}
