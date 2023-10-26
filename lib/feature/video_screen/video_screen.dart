import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/feature/video_screen/video_view.dart';

import '../../provider/get_status.dart';
import '../../utils/constants/colors.dart';
import 'get_thumbnail.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFetched = false;
    return Scaffold(
      body: Consumer<GetStatusProvider>(
        builder: (context, file, child) {
          if (!isFetched) {
            file.getStatus('mp4');
            Future.delayed(const Duration(milliseconds: 1), () {
              isFetched = true;
            });
          }
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: file.getVideos.length,
            itemBuilder: (context, index) {
              return file.isWhatsAppAvailable == false
                  ? const Center(
                      child: Text(
                          'WhatsApp Not Available Yet. Please Install WhatsApp'),
                    )
                  : file.getVideos.isEmpty
                      ? const Center(
                          child: Text('No Videos Found Yet.'),
                        )
                      : FutureBuilder<String>(
                          future: getThumbnail(file.getVideos[index].path),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VideoView(
                                            videoPath: file.getVideos[index].path,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: SColors.primary,
                                          ),
                                          child: Image.file(
                                            File(snapshot.data!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: SColors.primary,
                                            ),
                                            child: const Icon(
                                              Iconsax.play,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        );
            },
          );
        },
      ),
    );
  }
}
