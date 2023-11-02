import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/feature/video_screen/video_view.dart';
import 'package:statussaver/utils/constants/sizes.dart';

import '../../provider/get_status.dart';
import '../../service/admob_service.dart';
import '../../utils/constants/colors.dart';
import 'get_thumbnail.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

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
                                            videoPath:
                                                file.getVideos[index].path,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: SColors.primary,
                                          ),
                                          child: Image.file(
                                            File(snapshot.data!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(SSizes.borderRadiusLg)),
                                              color: SColors.primary,
                                            ),
                                            child: const Icon(
                                              Iconsax.video,
                                              color: Colors.white,
                                              size: 25,
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
      bottomNavigationBar: _bannerAd == null
          ? Container()
          : Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
    );
  }
}
