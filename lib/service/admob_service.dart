import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8049480871232781/7481562908';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return null;
    }
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8049480871232781/4345916062';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return null;
    }
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8049480871232781/6640034778';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return null;
    }
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad loaded: ${ad.adUnitId}.'),
    onAdClosed: (ad) => print('Ad closed: ${ad.adUnitId}.'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print('Ad failed to load: ${ad.adUnitId}, $error.');
    },
    onAdOpened: (ad) => print('Ad opened: ${ad.adUnitId}.'),
    onAdImpression: (ad) => print('Ad impression: ${ad.adUnitId}.'),
    onAdClicked: (ad) => print('Ad clicked: ${ad.adUnitId}.'),
  );
}
