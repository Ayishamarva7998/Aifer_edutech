import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wallpaper_app/constants/api_constants.dart';
import 'package:wallpaper_app/constants/url_constants.dart';
import 'package:wallpaper_app/models/image_model.dart';

class ApiService {
  final Dio _dio = Dio();

  fetchImages() async {
    try {
      final response = await _dio.get(
        UrlConstants.baseUrl +
            UrlConstants.photosEndPoint +
            UrlConstants.clientIdTag +
            ApiConstants.accessKey,
      );

      log(response.data.toString());

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        List<ImageModel> imageList = responseData.map((image) {
          return ImageModel.fromJson(image);
        }).toList();
        return imageList;
      } else {
        throw Exception("Error Fetching Image ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
