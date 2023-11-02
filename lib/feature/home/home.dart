import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/text_strings.dart';
import '../image_screen/images_screen.dart';
import '../video_screen/video_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            STexts.homeAppbarTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Iconsax.image),
                text: "Images",
              ),
              Tab(
                icon: Icon(Iconsax.video),
                text: "Videos",
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ImagesScreen(),
            VideosScreen(),
          ],
        ),
      ),
    );
  }
}
