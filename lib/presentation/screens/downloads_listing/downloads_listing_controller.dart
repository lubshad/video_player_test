import 'dart:convert';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/domain/entities/video_details.dart';

class DownloadsListingController extends ChangeNotifier {
  final box = GetStorage();
  List<VideoDetails> downloadedVideos = [
    // VideoDetails(
    //     title: "Animated Cross Fade(widget of the week)",
    //     videoUrl:
    //         "https://drive.google.com/uc?export=download&id=1aHR-e5vpJfwK89mRvosvMGjQmuNdEOrc",
    //     duration: const Duration(minutes: 2, seconds: 15),
    //     creatorName: "Flutter",
    //     creatorAvatarUrl:
    //         "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
    //     totalViews: 14000,
    //     uploadedOn: Timestamp.fromDate(DateTime(2020))),
    // VideoDetails(
    //     title: "Flow(widget of the week)",
    //     videoUrl:
    //         "https://drive.google.com/uc?export=download&id=1i7MZYOa7UnUYk02NEnwdzK5T3sjMlAiq",
    //     duration: const Duration(minutes: 2, seconds: 33),
    //     creatorName: "Flutter",
    //     creatorAvatarUrl:
    //         "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
    //     totalViews: 8000,
    //     uploadedOn: Timestamp.fromDate(DateTime(2021))),
    // VideoDetails(
    //     title: "Freezed(widget of the week)",
    //     videoUrl:
    //         "https://drive.google.com/uc?export=download&id=1yBYyh4d1fDO4mZef__Aj2JxlOGVK_tPC",
    //     duration: const Duration(minutes: 2, seconds: 56),
    //     creatorName: "Flutter",
    //     creatorAvatarUrl:
    //         "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
    //     totalViews: 18000,
    //     uploadedOn: Timestamp.fromDate(DateTime(2019))),
    // VideoDetails(
    //     title: "Refresh Indicator (widget of the week)",
    //     videoUrl:
    //         "https://drive.google.com/uc?export=download&id=17bx0QxRkJvnZCJ4nGtfZYdZMFSMrNNnO",
    //     duration: const Duration(minutes: 2, seconds: 00),
    //     creatorName: "Flutter",
    //     creatorAvatarUrl:
    //         "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
    //     totalViews: 22000,
    //     uploadedOn: Timestamp.fromDate(DateTime(2018))),
    // VideoDetails(
    //     title: "Theme (widget of the week)",
    //     videoUrl:
    //         "https://drive.google.com/uc?export=download&id=1zCgGctgJbnCJwO1JzmjKuM-majAIQtnD",
    //     duration: const Duration(minutes: 3, seconds: 22),
    //     creatorName: "Flutter",
    //     creatorAvatarUrl:
    //         "https://docs.flutter.dev/assets/images/docs/catalog-widget-placeholder.png",
    //     totalViews: 38000,
    //     uploadedOn: Timestamp.fromDate(DateTime(2021))),
  ];
  DownloadsListingController() {
    // for (VideoDetails video in downloadedVideos) {
    //   videosRef.add(video.toMap());
    // }
    // box.erase();
    var data = box.read("videos");
    setVideos(data);
    box.listenKey("videos", (value) {
      setVideos(value);
    });
  }

  bool checkDownloaded(VideoDetails videoDetails) => downloadedVideos
              .firstWhereOrNull((element) => element.id == videoDetails.id) ==
          null
      ? false
      : true;

  setVideos(data) {
    List jsonList = jsonDecode(data ?? jsonEncode([]));
    downloadedVideos =
        jsonList.map((e) => VideoDetails.fromMapLocal(e)).toList();
    notifyListeners();
  }

  void addToDownloads(VideoDetails videoDetails) async {
    logger.info("addting to download list");
    downloadedVideos.add(videoDetails);
    box.write(
        'videos', jsonEncode(downloadedVideos.map((e) => e.toMap()).toList()));
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Row(
      children: [
        const Text("Downloaded : "),
        Text(videoDetails.title),
      ],
    )));
  }
}
