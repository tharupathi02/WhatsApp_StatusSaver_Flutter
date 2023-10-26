import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/widgets/appbar.dart';
import '../../utils/constants/text_strings.dart';
import '../image_screen/images_screen.dart';
import '../video_screen/video_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = NavigationController();
    return Scaffold(
      appBar: SAppBar(
        title: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                STexts.homeAppbarTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                '${STexts.homeAppbarSubTitle} ${navController.selectedIndex.value == 0 ? 'Images' : 'Videos'}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          selectedIndex: navController.selectedIndex.value,
          onDestinationSelected: (index) =>
              navController.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.image), label: 'Images'),
            NavigationDestination(icon: Icon(Iconsax.video), label: 'Videos'),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: navController.selectedIndex.value,
          children: navController.screens,
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const ImagesScreen(),
    const VideosScreen(),
  ];
}
