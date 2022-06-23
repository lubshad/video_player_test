import 'package:flutter/cupertino.dart';
import 'package:video_player_test/data/core/firestore_utils.dart';
import 'package:video_player_test/domain/entities/video_details.dart';

class VideoListController extends ChangeNotifier {
  List<VideoDetails> availableVideos = [];
  VideoListController() {
    videosRef.snapshots().listen((event) {
      availableVideos =
          event.docs.map((e) => VideoDetails.fromMap(e.data(), e.id)).toList();
      notifyListeners();
    });
  }
}
