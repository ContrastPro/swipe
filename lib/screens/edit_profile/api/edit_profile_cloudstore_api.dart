import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:swipe/model/custom_user.dart';

class EditProfileCloudstoreAPI {
  EditProfileCloudstoreAPI._();

  static Future<String> uploadProfileImage({
    UserBuilder userProfile,
    File imageFile,
    String photoURL,
  }) async {
    String newPhotoURL;

    if (photoURL != null) {
      // Удаляем старое изображение
      Reference oldReference = FirebaseStorage.instance.refFromURL(photoURL);
      await oldReference.delete();
    }

    Reference newReference = FirebaseStorage.instance
        .ref("Swipe/Users/${userProfile.uid}")
        .child("avatar.jpg");

    await newReference.putFile(imageFile).then((snapshot) async {
      newPhotoURL = await snapshot.ref.getDownloadURL();
    }).catchError((error) => print("Failed to upload image: $error"));

    return newPhotoURL;
  }
}
