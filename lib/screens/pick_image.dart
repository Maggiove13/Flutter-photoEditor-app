import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> pickImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null; // Si el usuario cancela la selección
    }
  }
}
