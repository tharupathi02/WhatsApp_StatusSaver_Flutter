import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:statussaver/service/admob_service.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class ImageView extends StatefulWidget {
  final String? imagePath;

  const ImageView({super.key, this.imagePath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
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

  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 0,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Iconsax.arrow_left),
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
                Share.shareFiles([widget.imagePath.toString()]);
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
        ),
        bottomNavigationBar: _bannerAd == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
      ),
    );
  }
}
