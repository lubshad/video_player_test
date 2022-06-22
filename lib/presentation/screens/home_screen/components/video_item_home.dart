import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player_test/presentation/route.dart';
import 'package:video_player_test/presentation/screens/home_screen/components/thumbnail.dart';
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
    return InkWell(
      onTap: () {
        Get.until((route) => route.isFirst);
        Get.toNamed(AppRoute.videoPlayerScreen, arguments: videoDetails);
      },
      child: Column(
        children: [
          Thumbnail(videoUrl: videoDetails.videoUrl),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  CachedNetworkImageProvider(videoDetails.creatorAvatarUrl),
            ),
            title: Text(videoDetails.title),
            subtitle: Row(
              children: [
                Text(
                  videoDetails.creatorName,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 10),
                ),
                const DotSpacer(),
                Text(
                  videoDetails.totalViews.views,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 10),
                ),
                const DotSpacer(),
                Text(
                  timeago.format(videoDetails.uploadedOn.toDate()),
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DotSpacer extends StatelessWidget {
  const DotSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPaddingTiny),
      child: Text("•"),
    );
  }
}
