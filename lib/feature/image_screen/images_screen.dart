import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/provider/get_status.dart';
import 'package:statussaver/utils/constants/colors.dart';

import 'image_view.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

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
                          child: Container(
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
                        );
            },
          );
        },
      ),
    );
  }
}
