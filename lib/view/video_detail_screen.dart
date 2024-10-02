import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:medrobot_dradham/constants/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:medrobot_dradham/model/videos%20model/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailScreen extends StatefulWidget {
  final VideoModel video; // تمرير بيانات الفيديو

  VideoDetailScreen({required this.video});

  @override
  _VideoDetailScreenState createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      YoutubeExplode yt = YoutubeExplode();
      var videoId = YoutubePlayer.convertUrlToId(widget.video.videoUrl);

      if (videoId == null) {
        throw Exception("Failed to extract videoId");
      }

      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var streamInfo = manifest.muxed.bestQuality;

      videoPlayerController =
          VideoPlayerController.network(streamInfo.url.toString());
      await videoPlayerController!.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        fullScreenByDefault: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
      yt.close();
      setState(() {});
    } catch (e) {
      print("Error initializing video: $e");
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(
          widget.video.videoName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: chewieController != null
          ? Chewie(controller: chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
