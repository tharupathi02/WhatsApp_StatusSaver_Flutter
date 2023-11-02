import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/provider/get_status.dart';
import 'package:statussaver/service/admob_service.dart';
import 'package:statussaver/utils/constants/colors.dart';

import '../../utils/constants/sizes.dart';
import 'image_view.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
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
            file.getStatus('jpg');
            Future.delayed(const Duration(milliseconds: 1), () {
              isFetched = true;
            });
          }
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: file.getImages.length,
            itemBuilder: (context, index) {
              return file.isWhatsAppAvailable == false
                  ? const Center(
                      child: Text(
                          'WhatsApp Not Available Yet. Please Install WhatsApp'),
                    )
                  : file.getImages.isEmpty
                      ? const Center(
                          child: Text('No Images Found Yet.'),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageView(
                                  imagePath: file.getImages[index].path,
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
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(file.getImages[index].path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Image.file(
                                  File(file.getImages[index].path),
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
                                    Iconsax.image,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
