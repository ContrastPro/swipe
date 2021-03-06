import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAPI {
  static User currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
