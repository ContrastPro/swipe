import 'package:cloud_firestore/cloud_firestore.dart';

class DeveloperBuilder {
  // Personal User information
  String uid;
  String name;
  String lastName;
  String phone;
  String email;
  String photoURL;
  Timestamp createdAt;
  Timestamp updatedAt;

  DeveloperBuilder();

  DeveloperBuilder.fromMap(Map<String, dynamic> map)
      : uid = map["uid"],
        name = map["name"],
        lastName = map["lastName"],
        phone = map["phone"],
        email = map["email"],
        photoURL = map["photoURL"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return '\n********************************\n'
        '--- DeveloperBuilder ---'
        '\n>> uid: $uid'
        '\n>> name: $name'
        '\n>> lastName: $lastName'
        '\n>> phone: $phone'
        '\n>> email: $email'
        '\n>> photoURL: $photoURL'
        '\n>> createdAt: ${createdAt?.toDate()}'
        '\n>> updatedAt: ${updatedAt?.toDate()}'
        '\n********************************\n';
  }
}

class Developer {
  // Personal User information
  final String uid;
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String photoURL;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Developer(DeveloperBuilder developerBuilder)
      : uid = developerBuilder.uid,
        name = developerBuilder.name,
        lastName = developerBuilder.lastName,
        phone = developerBuilder.phone,
        email = developerBuilder.email?.toLowerCase(),
        photoURL = developerBuilder.photoURL,
        createdAt = developerBuilder.createdAt,
        updatedAt = developerBuilder.updatedAt;

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "email": email,
      "photoURL": photoURL,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
