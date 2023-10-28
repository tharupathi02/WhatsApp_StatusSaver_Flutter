import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:statussaver/service/admob_service.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../common/widgets/appbar.dart';
import '../../utils/constants/text_strings.dart';

class ImageView extends StatefulWidget {
  final String? imagePath;

  const ImageView({super.key, this.imagePath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          print('InterstitialAd loaded');
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          print('InterstitialAd failed to load: $error');
        },
      )
    );
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
                ImageGallerySaver.saveFile(widget.imagePath!).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Image Saved Successfully'),
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
                Share.shareFiles([widget.imagePath!]);
              },
              icon: const Icon(
                Iconsax.share,
                size: 20,
              ),
            ),
          ],
        ),
        body: Center(
          child: ZoomOverlay(
            twoTouchOnly: true,
            child: Image.file(
              File(widget.imagePath!),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
