import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../common/widgets/appbar.dart';
import '../../utils/constants/text_strings.dart';

class VideoView extends StatefulWidget {
  final String? videoPath;

  const VideoView({super.key, this.videoPath});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController:
          VideoPlayerController.file(File(widget.videoPath!)),
      autoInitialize: true,
      autoPlay: true,
      zoomAndPan: true,
      looping: true,
      allowMuting: true,
      aspectRatio: 9 / 16,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController!.dispose();
    _chewieController!.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              STexts.homeAppbarTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              STexts.homeAppbarSubTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ImageGallerySaver.saveFile(widget.videoPath!).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Video Saved Successfully'),
                  ),
                );
              });
            },
            icon: const Icon(
              Iconsax.document_download,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              Share.shareFiles([widget.videoPath.toString()]);
            },
            icon: const Icon(
              Iconsax.share,
              size: 20,
            ),
          ),
        ],
      ),
      body: Chewie(controller: _chewieController!),
    );
  }
}