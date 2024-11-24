import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'dart:ui' as ui;

import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/constants/text_constants.dart';
import 'package:wallpaper_app/utils/snackbar_utils.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.downloadUrl,
  });

  final String imageUrl;
  final String downloadUrl;

  Future<ui.Image> _getImage() {
    Completer<ui.Image> completer = Completer<ui.Image>();
    NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder<ui.Image>(
        future: _getImage(),
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          if (snapshot.hasData) {
            ui.Image? image = snapshot.data;
            return GestureDetector(
              onTap: () async {
                await downloadImage(downloadUrl, context);
              },
              child: RawImage(
                image: image,
                width: image?.width.toDouble(),
                height: image?.height.toDouble(),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
              ),
            );
          }
        },
      ),
    );
  }

  downloadImage(String downloadUrl, BuildContext context) async {
    log(downloadUrl);
    try {
      await FileDownloader.downloadFile(
        downloadDestination: DownloadDestinations.publicDownloads,
        notificationType: NotificationType.all,
        url: downloadUrl,
        onProgress: (fileName, progress) {
          log("File ${fileName}has ${progress} progress");
        },
        onDownloadCompleted: (path) {
          log("Download completed ${path}");
          SnackbarUtils.showSnackBar(
            context,
            TextConstants.imageDownloadMessage,
            Colors.green,
          );
        },
        onDownloadError: (errorMessage) {
          log(errorMessage);
          SnackbarUtils.showSnackBar(
            context,
            TextConstants.imageDownloadFailMessage,
            Colors.red,
          );
        },
      );
    } catch (e) {
      log(e.toString());

      SnackbarUtils.showSnackBar(
        context,
        TextConstants.imageDownloadFailMessage,
        Colors.red,
      );
    }
  }
}
