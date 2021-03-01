import 'package:cloud_firestore/cloud_firestore.dart';

class NotaryFirestoreAPI {
  NotaryFirestoreAPI._();

  static Stream<QuerySnapshot> getNotary() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .snapshots();
  }

  static Future<void> addNotary() async {
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .add({
      "name": "Valio",
      "lastName": "Oltermanni",
      "phone": "+38 055 610 61 03",
      "email": "swipe@gmail.com",
      "photoURL":
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200",
      "createAt": Timestamp.now(),
    });
  }
}
