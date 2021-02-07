import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class LocalImagePicker {
  File _imageFile;

  File get imageFile => _imageFile;

  Future<void> getLocalImage() async {
    final ImagePicker picker = ImagePicker();

    // Get Image
    final PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);

      // Crop Image
      File cropImage = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        maxWidth: 165,
        maxHeight: 165,
        compressQuality: 100,
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );

      _imageFile = cropImage ?? null;
    }
  }
}
