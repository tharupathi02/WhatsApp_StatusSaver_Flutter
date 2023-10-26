import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statussaver/utils/constants/root_file.dart';

class GetStatusProvider extends ChangeNotifier {

  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  bool _isWhatsAppAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsAppAvailable => _isWhatsAppAvailable;

  void getStatus(String ext) async {
    final permissionStatus = await Permission.manageExternalStorage.status;

    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();
      return;
    }

    if (permissionStatus.isGranted) {
      final directory = Directory(RootFile.whatsappPath);

      if (directory.existsSync()) {
        final items = directory.listSync();
        if (ext == 'mp4') {
          _getVideos.clear();
          _getVideos = items.where((element) => element.path.endsWith('.mp4')).toList();
        } else {
          _getImages.clear();
          _getImages = items.where((element) => element.path.endsWith('.jpg')).toList();
        }
        _isWhatsAppAvailable = true;
        notifyListeners();

      } else {
        _isWhatsAppAvailable = false;
        notifyListeners();
      }
    }

  }
}