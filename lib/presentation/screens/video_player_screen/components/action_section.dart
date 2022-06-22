import 'dart:ui';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:video_player_test/domain/entities/video_details.dart';
import 'dart:isolate';

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

  final ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort?.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();


    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");


    _receivePort.listen((message) {
      progress = message[2];
      if (mounted) {
        setState(() {});
      }
      DownloadTaskStatus status = message[1];
      status == DownloadTaskStatus.complete;
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            child: const Icon(CupertinoIcons.chevron_back),
            onTap: () {},
          ),
          CustomIconButton(
              onTap: () => startDownload(widget.videoDetails),
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
                    children: [
                      const Icon(
                        CupertinoIcons.arrowtriangle_down_fill,
                        color: screaminGreen,
                      ),
                      SizedBox(
                        width: 100,
                        child: LinearProgressIndicator(
                          value: progress.toDouble() / 100,
                        ),
                      ),
                      defaultSpacerHorizontalSmall
                    ],
                  );
                }
              })),
          CustomIconButton(
            child: const Icon(CupertinoIcons.chevron_forward),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void startDownload(VideoDetails videoDetails) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final tempDir = await getTemporaryDirectory();

      final id = await FlutterDownloader.enqueue(
        url: videoDetails.videoUrl,
        savedDir: tempDir.path,
        fileName: "${videoDetails.title}.mp4",
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      logger.info("Permission deined");
    }
  }
}
