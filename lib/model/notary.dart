import 'package:cloud_firestore/cloud_firestore.dart';

class NotaryBuilder {
  String id;
  String name;
  String lastName;
  String phone;
  String email;
  String photoURL;
  Timestamp createAt;
  Timestamp updateAt;

  NotaryBuilder();

  NotaryBuilder.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        lastName = map["lastName"],
        phone = map["phone"],
        email = map["email"],
        photoURL = map["photoURL"],
        createAt = map["createAt"],
        updateAt = map["updateAt"];

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
        '\n>> createAt: ${createAt?.toDate()}'
        '\n>> updateAt: ${updateAt?.toDate()}'
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
  final Timestamp createAt;
  final Timestamp updateAt;

  Notary(NotaryBuilder notaryBuilder)
      : id = notaryBuilder.id,
        name = notaryBuilder.name,
        lastName = notaryBuilder.lastName,
        phone = notaryBuilder.phone,
        email = notaryBuilder.email,
        photoURL = notaryBuilder.photoURL,
        createAt = notaryBuilder.createAt,
        updateAt = notaryBuilder.updateAt;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "email": email,
      "photoURL": photoURL,
      "createAt": createAt,
      "updateAt": updateAt,
    };
  }
}
