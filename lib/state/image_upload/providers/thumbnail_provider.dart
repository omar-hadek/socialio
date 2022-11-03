import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/state/image_upload/extentions/get_image_aspect_ratio.dart';

import 'package:video_thumbnail/video_thumbnail.dart';

import '../exceptions/could_not_build_thumbnail_exception.dart';
import '../models/file_type.dart';
import '../models/image_with_aspect_ratio.dart';
import '../models/thumbnail_request.dart';

final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>((ref, request) async {
  final Image image;

  switch (request.fileType) {
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;
    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thumb == null) {
        throw const CouldNotBuildThumbnailException();
      }
      image = Image.memory(
        thumb,
        fit: BoxFit.fitHeight,
      );
  }

  final aspectRatio = await image.getAspectRatio();
  return ImageWithAspectRatio(
    image: image,
    aspectRatio: aspectRatio,
  );
});


// Future<ImageWithAspectRatio> thumbnail(
//   ThumbnailRef ref, {
//   required ThumbnailRequest request,
// }) async {
  
// }