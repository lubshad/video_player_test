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
          Thumbnail(thumbnail: videoDetails.thumbnail),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  CachedNetworkImageProvider(videoDetails.creatorAvatarUrl),
            ),
            title: Text(videoDetails.title),
            subtitle: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.caption,
                children: [
                  TextSpan(
                      text: videoDetails.creatorName,
                  ),
                  const WidgetSpan(child: DotSpacer()),
                  TextSpan(
                    text: videoDetails.totalViews.views,
                  ),
                  const WidgetSpan(child: DotSpacer()),
                  TextSpan(
                    text: timeago.format(videoDetails.uploadedOn.toDate()),
                  ),
                ],
              ),
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
