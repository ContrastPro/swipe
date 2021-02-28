import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ChatImagePicker {
  static Future<File> getLocalImage() async {
    final ImagePicker picker = ImagePicker();

    // Get Image
    final PickedFile pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
