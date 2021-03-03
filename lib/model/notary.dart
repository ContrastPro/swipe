import 'package:cloud_firestore/cloud_firestore.dart';

class NotaryBuilder {
  String id;
  String name;
  String lastName;
  String phone;
  String email;
  String photoURL;
  Timestamp createdAt;
  Timestamp updatedAt;

  NotaryBuilder();

  NotaryBuilder.fromMap(Map<String, dynamic> map)
      : id = map["id"],
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
        '--- NotaryBuilder ---'
        '\n>> id: $id'
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

class Notary {
  final String id;
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String photoURL;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Notary(NotaryBuilder notaryBuilder)
      : id = notaryBuilder.id,
        name = notaryBuilder.name,
        lastName = notaryBuilder.lastName,
        phone = notaryBuilder.phone,
        email = notaryBuilder.email,
        photoURL = notaryBuilder.photoURL,
        createdAt = notaryBuilder.createdAt,
        updatedAt = notaryBuilder.updatedAt;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
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
