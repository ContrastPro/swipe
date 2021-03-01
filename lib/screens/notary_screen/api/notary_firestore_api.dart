import 'package:cloud_firestore/cloud_firestore.dart';

class NotaryFirestoreAPI {
  static Stream<QuerySnapshot> getNotary() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notary")
        .snapshots();
  }

  static Future<void> addNotary() async {
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notary")
        .add({
      "name": "Alex",
      "lastName": "Blake",
      "phone": "+38 099 510 63 03",
      "email": "swipe@gmail.com",
      "photoURL": "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200",
    });
  }
}
