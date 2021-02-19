import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

class EditProfileCloudstoreAPI {
  EditProfileCloudstoreAPI._();

  static Future<String> uploadProfileImage({
    File imageFile,
    String photoURL,
  }) async {
    String newPhotoURL;
    final User user = AuthFirebaseAPI.getCurrentUser();

    if (photoURL != null) {
      // Удаляем старое изображение
      Reference oldReference = FirebaseStorage.instance.refFromURL(photoURL);
      await oldReference.delete();
    }

    Reference newReference = FirebaseStorage.instance
        .ref("Swipe/Users/${user.uid}")
        .child("avatar.jpg");

    await newReference.putFile(imageFile).then((snapshot) async {
      newPhotoURL = await snapshot.ref.getDownloadURL();
    }).catchError((error) => print("Failed to upload image: $error"));

    return newPhotoURL;
  }
}
