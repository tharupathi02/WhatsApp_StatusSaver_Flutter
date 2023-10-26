import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../common/widgets/appbar.dart';
import '../../utils/constants/text_strings.dart';

class ImageView extends StatelessWidget {
  final String? imagePath;

  const ImageView({super.key, this.imagePath});

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
                ImageGallerySaver.saveFile(imagePath!).then((value) {
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
                Share.shareFiles([imagePath!]);
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
              File(imagePath!),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
