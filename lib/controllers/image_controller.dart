import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/image_model.dart';
import 'package:wallpaper_app/services/api_service.dart';

class ImageController extends ChangeNotifier {
  ApiService _service = ApiService();
  List<ImageModel>? imageList;
  bool isLoading = false;

  fetchImages() async {
    isLoading = true;
    try {
      imageList = await _service.fetchImages();
      isLoading = false;

      notifyListeners();
    } catch (e) {
      imageList = [];
      log(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }
}
