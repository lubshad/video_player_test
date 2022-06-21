class VideoDetails {
  final String title;
  final String videoUrl;
  final Duration duration;
  final String thumbnailUrl;
  final String creatorName;
  final String creatorAvatarUrl;
  final int totalViews;
  final DateTime uploadedOn;

  VideoDetails(
      {required this.title,
      required this.videoUrl,
      required this.duration,
      required this.thumbnailUrl,
      required this.creatorName,
      required this.creatorAvatarUrl,
      required this.totalViews,
      required this.uploadedOn});
}