import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player_test/utils/extensions.dart';

import '../../../../domain/entities/video_details.dart';
import '../../../../utils/constants.dart';

class VideoItemHome extends StatelessWidget {
  const VideoItemHome({
    Key? key,
    required this.videoDetails,
  }) : super(key: key);

  final VideoDetails videoDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AspectRatio(
          aspectRatio: landscapeAspectRatio,
          child: Placeholder(),
        ),
        ListTile(
          leading: const CircleAvatar(),
          title: Text(videoDetails.title),
          subtitle: Row(
            children: [
              Text(
                videoDetails.creatorName,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
              ),
              Text(
                videoDetails.totalViews.views,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
              ),
              Text(
                timeago.format(videoDetails.uploadedOn),
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
              ),
            ],
          ),
        )
      ],
    );
  }
}
