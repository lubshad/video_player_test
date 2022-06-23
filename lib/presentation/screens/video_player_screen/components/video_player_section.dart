import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_test/domain/entities/video_details.dart';
import 'package:video_player_test/presentation/screens/downloads_listing/downloads_listing_controller.dart';
import 'package:video_player_test/utils/encryption.dart';

import '../../../../utils/constants.dart';
import 'components/bottom_controlls.dart';

class VideoPlayerSection extends StatefulWidget with WidgetsBindingObserver {
  const VideoPlayerSection({
    Key? key,
    required this.videoDetails,
  }) : super(key: key);

  final VideoDetails videoDetails;

  @override
  State<VideoPlayerSection> createState() => _VideoPlayerSectionState();
}

class _VideoPlayerSectionState extends State<VideoPlayerSection> {
  VideoPlayerController? videoPlayerController;
  DownloadsListingController downloadsListingController = Get.find();
  @override
  void initState() {
    super.initState();
    videoPlayerController =
        // VideoPlayerController.network(
        //     "https://videosforapp123.s3.ap-south-1.amazonaws.com/widget%20of%20the%20week/animated%20cross%20fade.mp4?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFYaCmFwLXNvdXRoLTEiRjBEAiAlfqjTBxaMJ1LalPzjAlS%2Bev33WwVeBRres8sfT0yDlgIgYetOxBwt2kv0YBiCa70kUhkZTZAGopeLIfoLpAPrcVkq5AIIcBABGgwzMzUzNzQzMTEwODQiDOoxVX9%2BW1eeoa6NxyrBAhRIJxhL2HHDpWpxzBdwSE%2Bne62HHO5tAdq7Qrmyq0N2eFV3lQUf6ScYQ3leq31OOLJBeTgkMSxUNC3WlphUGaXN1Xv7tf1Q0pKVRXj7DXvnCH9wNIVsw%2BTMZ3wmm8TIgOqnESEzRXvvg%2BCk7tkgNU2QB7qhSeurzL%2BHL7Q7yCq48mk9cBBHKVWMePz79VeDw3pnkfLnxKSe%2BQOBvUoTpXjdPLMg4jVoXPO9fqng0YjFSyJ%2FiuL4MtYp1aviMqs7ULmxg0tFYpyS4XdEjKTNUYbWjEGIOPMyYiTzbu6ZcONwU%2BeyOpV9LEuChpGHaSPgd9B29cEOAQgKXR6vKYuOcqchy340NHDNuxEgt0JDP7dtClV0iWXdgB6VFsokBZZCy%2FdR%2FmRqQB6BO7t202zDk4uq6bo7ZXPXSDx2swfmeB%2F8QTCEkNCVBjq0Ah3VujgqYuebaOhRkjiulpqm%2B7rN8LI24hrAYhu70SL%2FUvewsLrdqOO5%2B4QSv6ozBkwwuzyvQrsIPLsBJkadW02XQZEf%2Bss0rUpWsqqCn00pqIF4WN0MXpqdi5AymAntu4PybjHnuZGftHywuaVTb6eqARhrhZy%2FJd%2BLbIRhHfzOdG%2BVaePKcxTpPEmGto3Qtu%2BR2nzi92JddsKdxeTMUIIEe8JhDJygBvA%2Bq3bowbLKE7amFzn3id68JAKCneC6doU9pZ2Xfq%2Fd49DxpRSpmDsb1DPyFLxwjRBnSVkmk3AVWD8QrFDIN0CnkPXqpbY4iyYoDcDHNG7ylVAvAVLrRFak7lzH7kC8rSxx2NoR1Pv79Lxi%2BrkqCvc%2BirCR8EMeBUN5XVtHSajNRMTayoim1L6MllBj&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220623T071949Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAU4FO532WL4SII3GO%2F20220623%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Signature=2a26205f1eff94c4fc8ef943b96b649e95a0f090713a1efef678ce019988dd18");
        VideoPlayerController.network(widget.videoDetails.videoUrl)
          ..initialize().then((value) => setState(() {}));
    checkFileDownloaded();
    // videoPlayerController
    //     .initialize()
    //     .then((value) => videoPlayerController.play());
  }

  checkFileDownloaded() async {
    var downloadedItem = downloadsListingController.downloadedVideos
        .firstWhereOrNull((element) => element.id == widget.videoDetails.id);
    if (downloadedItem != null) {
      loadFromLocal(downloadedItem);
    } else {
      videoPlayerController?.play();
    }
  }

  loadFromLocal(VideoDetails videoDetails) async {
    logger.info("loading from local");
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final decryptedFile =
          await EncryptionUtils.decryptDownloadedFile(videoDetails.id!);
      logger.info(decryptedFile?.path);
      if (decryptedFile != null) {
        videoPlayerController = VideoPlayerController.file(decryptedFile)
          ..initialize().then((value) => setState(() {}));
      }
    } else {
      logger.info("Permission deined");
    }
    videoPlayerController?.play();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      videoPlayerController?.pause();
    }
  }

  void skipBackward() {
    Duration currentDuration =
        videoPlayerController?.value.position ?? Duration.zero;
    if (currentDuration.inSeconds < 10) return;
    Duration newPosition = Duration(seconds: currentDuration.inSeconds - 10);
    videoPlayerController?.seekTo(newPosition);
  }

  void skipForward() {
    Duration currentDuration =
        videoPlayerController?.value.position ?? Duration.zero;
    Duration totalDuraton =
        videoPlayerController?.value.duration ?? Duration.zero;
    if (totalDuraton.inSeconds - currentDuration.inSeconds < 10) return;
    Duration newPosition = Duration(seconds: currentDuration.inSeconds + 10);
    videoPlayerController?.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: landscapeAspectRatio,
      child: AnimatedBuilder(
          animation: videoPlayerController!,
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                    color: Colors.black,
                    child: !videoPlayerController!.value.isInitialized
                        ? const DefaultLoadingWidget()
                        : VideoPlayer(videoPlayerController!)),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: skipBackward,
                        // child: Container(
                        //   color: Colors.red,
                        // ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: skipForward,
                        // child: Container(
                        //   color: Colors.blue,
                        // ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                    visible: videoPlayerController!.value.isInitialized,
                    child: BottomControlls(
                        videoPlayerController: videoPlayerController!)),
              ],
            );
          }),
    );
  }
}
