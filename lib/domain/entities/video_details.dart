import 'package:cloud_firestore/cloud_firestore.dart';

class VideoDetails {
  final String? id;
  final String title;
  final String videoUrl;
  final Duration duration;
  final String creatorName;
  final String creatorAvatarUrl;
  final int totalViews;
  final Timestamp uploadedOn;

  VideoDetails(
      {required this.title,
      required this.videoUrl,
      required this.duration,
      required this.creatorName,
      required this.creatorAvatarUrl,
       this.id,
      required this.totalViews,
      required this.uploadedOn});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'title': title,
      'videoUrl': videoUrl,
      'duration': duration.inSeconds,
      'creatorName': creatorName,
      'creatorAvatarUrl': creatorAvatarUrl,
      'views': totalViews,
      'uploadedOn': uploadedOn.millisecondsSinceEpoch,
    };
  }

  factory VideoDetails.fromMap(Map<String, dynamic> map, String id) {
    return VideoDetails(
        id: id,
        title: map["title"],
        videoUrl: map["videoUrl"],
        duration: Duration(seconds: map["duration"]),
        creatorName: map["creatorName"],
        creatorAvatarUrl: map["creatorAvatarUrl"],
        totalViews: map["views"],
        uploadedOn: Timestamp.fromMicrosecondsSinceEpoch(map["uploadedOn"]));
  }

  factory VideoDetails.fromMapLocal(Map<String, dynamic> map) {
    return VideoDetails(
        id: map["id"],
        title: map["title"],
        videoUrl: map["videoUrl"],
        duration: Duration(seconds: map["duration"]),
        creatorName: map["creatorName"],
        creatorAvatarUrl: map["creatorAvatarUrl"],
        totalViews: map["views"],
        uploadedOn: Timestamp.fromMillisecondsSinceEpoch(map["uploadedOn"]));
  }
}
