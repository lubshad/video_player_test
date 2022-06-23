import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/domain/entities/video_details.dart';
import 'package:video_player_test/presentation/route.dart';
import 'package:video_player_test/presentation/screens/downloads_listing/downloads_listing_controller.dart';
import 'package:http/http.dart' as http;
import 'package:video_player_test/presentation/screens/video_list/video_list_controller.dart';
import 'package:video_player_test/utils/encryption.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';

class ActionSection extends StatefulWidget {
  const ActionSection({Key? key, required this.videoDetails}) : super(key: key);

  final VideoDetails videoDetails;

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection> {
  int progress = 0;

  // final ReceivePort _receivePort = ReceivePort();
  DownloadsListingController downloadsListingController = Get.find();
  VideoListController videoListController = Get.find();

  // static downloadingCallback(id, status, progress) {
  //   SendPort sendPort = IsolateNameServer.lookupPortByName("downloading")!;
  //   sendPort.send([id, status, progress]);
  // }

  @override
  void initState() {
    super.initState();

    // IsolateNameServer.registerPortWithName(
    //     _receivePort.sendPort, "downloading");

    // _receivePort.listen((message) {
    //   setState(() {
    //     progress = message[2];
    //   });

    //   DownloadTaskStatus status = message[1];
    //   if (status == DownloadTaskStatus.complete) {
    //     downloadsListingController.addToDownloads(widget.videoDetails);
    //   }
    // });

    // FlutterDownloader.registerCallback(downloadingCallback);

    if (downloadsListingController.checkDownloaded(widget.videoDetails)) {
      setState(() {
        progress = 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: IconTheme(
        data: const IconThemeData(
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              onTap: shuffle,
              child: const Icon(CupertinoIcons.chevron_back),
            ),
            CustomIconButton(
                onTap: progress != 0
                    ? null
                    : () => startDownload(widget.videoDetails),
                child: Builder(builder: (context) {
                  if (progress == 0) {
                    return Row(
                      children: [
                        const Icon(
                          CupertinoIcons.arrowtriangle_down_fill,
                          color: screaminGreen,
                        ),
                        Text(
                          "Download",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 16),
                        ),
                        defaultSpacerHorizontalSmall
                      ],
                    );
                  } else if (progress == 100) {
                    return Row(
                      children: [
                        const Icon(
                          CupertinoIcons.check_mark,
                          color: screaminGreen,
                        ),
                        Text(
                          "Downloaded",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 16),
                        ),
                        defaultSpacerHorizontalSmall
                      ],
                    );
                  } else {
                    return Row(
                      children: const [
                        Icon(
                          CupertinoIcons.arrowtriangle_down_fill,
                          color: screaminGreen,
                        ),
                        SizedBox(
                            width: defaultPadding,
                            height: defaultPadding,
                            child: CircularProgressIndicator()
                            // child: LinearProgressIndicator(
                            //   value: progress.toDouble() / 100,
                            // ),
                            ),
                        defaultSpacerHorizontalSmall
                      ],
                    );
                  }
                })),
            CustomIconButton(
              onTap: shuffle,
              child: const Icon(CupertinoIcons.chevron_forward),
            ),
          ],
        ),
      ),
    );
  }

  void startDownload(VideoDetails videoDetails) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      setState(() {
        progress = 10;
      });
      final response = await http.get(Uri.parse(videoDetails.videoUrl));
      await EncryptionUtils.encryptAndSave(response, videoDetails);
      downloadsListingController.addToDownloads(videoDetails);
      // final id = await FlutterDownloader.enqueue(
      //   url: videoDetails.videoUrl,
      //   savedDir: appDir!.path,
      //   fileName: "${videoDetails.title}.mp4",
      //   showNotification: true,
      //   openFileFromNotification: true,
      // );
      setState(() {
        progress = 100;
      });
    } else {
      logger.info("Permission deined");
    }
  }

  void shuffle() {
    Get.back();
    videoListController.availableVideos.shuffle();
    Get.toNamed(AppRoute.videoPlayerScreen,
        arguments: videoListController.availableVideos[0]);
  }
}
