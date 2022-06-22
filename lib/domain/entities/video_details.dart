import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class VideoDetails {
  final String title;
  final String videoUrl;
  final Duration duration;
  final String creatorName;
  final String creatorAvatarUrl;
  final int totalViews;
  final DateTime uploadedOn;

  VideoDetails(
      {required this.title,
      required this.videoUrl,
      required this.duration,
      required this.creatorName,
      required this.creatorAvatarUrl,
      required this.totalViews,
      required this.uploadedOn});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'videoUrl': videoUrl,
      'duration': duration.inSeconds,
      'creatorName': creatorName,
      'creatorAvatarUrl': creatorAvatarUrl,
      'totalViews': totalViews,
      'uploadedOn': uploadedOn.millisecondsSinceEpoch,
    };
  }

  factory VideoDetails.fromMap(Map<String, dynamic> map) {
    Timestamp timestamp = map["uploadedOn"];
    return VideoDetails(
        title: map["title"],
        videoUrl: map["videoUrl"],
        duration: Duration(seconds: map["duration"]),
        creatorName: map["creatorName"],
        creatorAvatarUrl: map["creatorAvatarUrl"],
        totalViews: map["views"],
        uploadedOn: timestamp.toDate());
  }

  String toJson() => json.encode(toMap());

  factory VideoDetails.fromJson(String source) =>
      VideoDetails.fromMap(json.decode(source));
}
