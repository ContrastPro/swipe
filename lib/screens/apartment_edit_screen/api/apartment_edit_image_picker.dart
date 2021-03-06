import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ApartmentEditImagePicker with ChangeNotifier {
  List<File> _imageFileList = <File>[];
  List<File> get imageFileList => _imageFileList;

  List<String> _imageUrlList = <String>[];
  List<String> get imageUrlList => _imageUrlList;

  ApartmentEditImagePicker({@required List<String> imageUrlList}){
    _imageUrlList.addAll(imageUrlList);
  }

  Future<void> getLocalImage() async {
    File imageFile;
    final ImagePicker picker = ImagePicker();

    // Get Image
    final PickedFile pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      // Crop Image
      File cropImage = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        maxWidth: 1102,
        maxHeight: 735,
        compressQuality: 80,
        aspectRatioPresets: [CropAspectRatioPreset.ratio5x3],
      );

      if (cropImage != null) {
        _imageFileList.add(cropImage);
        notifyListeners();
      }
    }
  }

  void deleteImage(int index) {
    _imageFileList.removeAt(index);
    notifyListeners();
  }
}
