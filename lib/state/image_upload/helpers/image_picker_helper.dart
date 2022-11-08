import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialio/state/image_upload/extentions/to_file.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageFromGallery() async {
    return _imagePicker.pickImage(source: ImageSource.gallery).toFile();
  }

  static Future<File?> pickVideoFromGallery() async {
    return _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
  }
}
