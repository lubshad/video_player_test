import 'package:basic_template/packages/default_loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/presentation/screens/home_screen/components/video_item_home.dart';

import '../../../../data/core/firestore_utils.dart';
import '../../../../domain/entities/video_details.dart';

class VideoList extends StatelessWidget {
  const VideoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: videosRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const DefaultLoadingWidget();
          }
          final videos = snapshot.data!.docs
              .map((e) => VideoDetails.fromMap(e.data()))
              .toList();
          return ListView.separated(
            separatorBuilder: ((context, index) => const Divider()),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final videoDetails = videos[index];
              return VideoItemHome(
                videoDetails: videoDetails,
              );
            },
          );
        });
  }
}
