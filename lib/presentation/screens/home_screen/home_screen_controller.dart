import 'package:flutter/cupertino.dart';
import 'package:video_player_test/domain/entities/video_details.dart';

class HomeScreenController extends ChangeNotifier {
  List<VideoDetails> availableVideos = [
    VideoDetails(
        title: "Whats on my macbook pro",
        videoUrl: "https://www.youtube.com/watch?v=3GP2lkI7ZHw",
        duration: const Duration(minutes: 10, seconds: 30),
        creatorName: "Your Average Tech Bro",
        creatorAvatarUrl: "creatorAvatarUrl",
        totalViews: 1506,
        uploadedOn: DateTime.now()),
    VideoDetails(
        title: "Adaptive Design Demo",
        videoUrl: "https://www.youtube.com/watch?v=3GP2lkI7ZHw",
        duration: const Duration(minutes: 10, seconds: 30),
        creatorName: "Flutter",
        creatorAvatarUrl: "creatorAvatarUrl",
        totalViews: 1506,
        uploadedOn: DateTime.now())
  ];
}
