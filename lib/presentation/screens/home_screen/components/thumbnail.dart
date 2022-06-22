import 'dart:typed_data';

import 'package:basic_template/packages/default_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../utils/constants.dart';

class Thumbnail extends StatefulWidget {
  const Thumbnail({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  State<Thumbnail> createState() => _ThumbnailState();
}

class _ThumbnailState extends State<Thumbnail> {
  Uint8List? thumbnailMemmoryImage;

  @override
  void initState() {
    createThumbnailImage();
    super.initState();
  }

  void createThumbnailImage() async {
    thumbnailMemmoryImage = await VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          512, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 10,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: landscapeAspectRatio,
      child: thumbnailMemmoryImage == null
          ? const DefaultLoadingWidget()
          : Image.memory(
              thumbnailMemmoryImage!,
              fit: BoxFit.cover,
            ),
    );
  }
}
