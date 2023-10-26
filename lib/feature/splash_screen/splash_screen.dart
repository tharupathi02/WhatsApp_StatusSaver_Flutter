import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statussaver/feature/home/home.dart';

import '../../utils/constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    navigate();
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage(SImages.lightAppLogo)),
      ),
    );
  }
}
