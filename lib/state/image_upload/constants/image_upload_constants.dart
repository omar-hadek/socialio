import 'package:flutter/foundation.dart' show immutable;

@immutable
class ImageUploadConstants {
  // for photos
  static const imageThumbnailWidth = 150;

  // for videos
  static const videoThumbnailMaxHeight = 400;
  static const videoThumbnailQuality = 75;

  const ImageUploadConstants._();
}
