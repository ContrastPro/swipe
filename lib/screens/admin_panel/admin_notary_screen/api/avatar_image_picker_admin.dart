import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AvatarImagePickerAdmin {
  AvatarImagePickerAdmin._();

  static Future<File> getLocalImage() async {
    final ImagePicker picker = ImagePicker();
    File imageFile;

    // Get Image
    final PickedFile pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      // Crop Image
      File cropImage = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        maxWidth: 165,
        maxHeight: 165,
        compressQuality: 100,
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
      imageFile = cropImage ?? null;
    }

    return imageFile;
  }
}
